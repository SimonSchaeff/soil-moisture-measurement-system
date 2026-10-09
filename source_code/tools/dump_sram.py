#!/usr/bin/env python3
"""
Plant Health System — Soil Moisture Live Monitor
-------------------------------------------------
Reads from PolarFire SoC UART (U54_3) via COM21 and shows a live chart.
New data arrives every 10 seconds. Just run:  python dump_sram.py
"""

import time
import sys
import threading

try:
    import serial
except ImportError:
    print("ERROR: pyserial not installed.  Run:  pip install pyserial")
    sys.exit(1)

try:
    import matplotlib.pyplot as plt
    import matplotlib.animation as animation
    from matplotlib.ticker import MultipleLocator
except ImportError:
    print("ERROR: matplotlib not installed.  Run:  pip install matplotlib")
    sys.exit(1)

# ─────────────────────────────────────────────────────────────────────────────
# Settings
# ─────────────────────────────────────────────────────────────────────────────
PORT          = "COM21"
BAUD          = 115200
SAMPLE_TIME_S = 10        # seconds between stored values  (matches e51.c)
REFRESH_MS    = 2000      # chart redraw interval in ms
UART_TIMEOUT  = 5.0       # seconds

# ─────────────────────────────────────────────────────────────────────────────
# Shared state  (written by background thread, read by animation)
# ─────────────────────────────────────────────────────────────────────────────
_lock       = threading.Lock()
_times_s    = []
_humids     = []
_status     = "Connecting to " + PORT + " …"
_last_count = -1
_new_flash  = [False]


# ─────────────────────────────────────────────────────────────────────────────
# UART
# ─────────────────────────────────────────────────────────────────────────────
def _open_port() -> serial.Serial:
    ser = serial.Serial(
        port=PORT, baudrate=BAUD,
        bytesize=serial.EIGHTBITS,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        timeout=UART_TIMEOUT
    )
    time.sleep(0.3)
    ser.reset_input_buffer()
    return ser


def _fetch(ser: serial.Serial) -> list:
    """Send DUMP, skip echo lines, return list of (time_s, humidity_pct)."""
    # sync: send a bare CR to bring the board to a clean prompt state.
    # The board reads it as empty input → "Unknown command" → back to prompt.
    # Avoids the stale LF left in the board's UART FIFO by a previous DUMP\r\n.
    ser.write(b"\r")
    ser.flush()
    time.sleep(0.15)          # wait for "Unknown command" response to arrive
    ser.reset_input_buffer()  # discard it

    # send DUMP with CR only — no trailing LF so nothing is left in the FIFO
    ser.write(b"DUMP\r")
    ser.flush()

    for _ in range(20):
        raw = ser.readline().decode("ascii", errors="replace").strip()
        if raw.startswith("COUNT="):
            break
    else:
        return []

    records = []
    while True:
        raw = ser.readline().decode("ascii", errors="replace").strip()
        if raw == "END" or raw == "":
            break
        parts = raw.split(",")
        if len(parts) != 2:
            continue
        try:
            records.append((int(parts[0]) * SAMPLE_TIME_S, int(parts[1])))
        except ValueError:
            continue
    return records


# ─────────────────────────────────────────────────────────────────────────────
# Background fetch thread
# ─────────────────────────────────────────────────────────────────────────────
def _fetch_thread():
    global _status
    ser = None

    while ser is None:
        try:
            ser = _open_port()
            with _lock:
                _status = f"Connected to {PORT} — waiting for first sample …"
        except Exception as e:
            with _lock:
                _status = f"Cannot open {PORT}: {e}  — retrying …"
            time.sleep(3)

    while True:
        try:
            records = _fetch(ser)
            with _lock:
                global _last_count
                if records:
                    new_count = len(records)
                    xs = [r[0] for r in records]
                    ys = [r[1] for r in records]
                    if new_count != _last_count:
                        _new_flash[0] = True
                        _last_count = new_count
                    _times_s.clear(); _times_s.extend(xs)
                    _humids.clear();  _humids.extend(ys)
                    _status = (
                        f"Samples: {new_count}   │   "
                        f"Duration: {xs[-1]/60:.1f} min   │   "
                        f"Latest: {ys[-1]}%   │   "
                        f"Min: {min(ys)}%   Max: {max(ys)}%   "
                        f"Avg: {sum(ys)/len(ys):.1f}%"
                    )
                else:
                    _status = f"Connected to {PORT} — SRAM empty, waiting …"
        except Exception as e:
            _status = f"Read error: {e}"

        time.sleep(SAMPLE_TIME_S)


# ─────────────────────────────────────────────────────────────────────────────
# Chart
# ─────────────────────────────────────────────────────────────────────────────
def _build_chart():
    BG_DARK  = "#0d1117"
    BG_PLOT  = "#161b22"
    BLUE     = "#58a6ff"
    GREEN    = "#3fb950"
    ORANGE   = "#f0883e"
    GRID_COL = "#21262d"
    TEXT_COL = "#c9d1d9"
    DIM_COL  = "#8b949e"

    fig, ax = plt.subplots(figsize=(15, 7))
    fig.patch.set_facecolor(BG_DARK)
    ax.set_facecolor(BG_PLOT)
    fig.subplots_adjust(left=0.07, right=0.97, top=0.88, bottom=0.13)

    fig.text(0.5, 0.95,
             "Plant Health System  —  Soil Moisture Measurement",
             ha="center", va="top",
             color=TEXT_COL, fontsize=16, fontweight="bold")

    ax.set_xlabel("Time [s]", color=TEXT_COL, fontsize=12, labelpad=6)
    ax.set_ylabel("Humidity [%]", color=TEXT_COL, fontsize=12, labelpad=6)
    ax.tick_params(axis="both", colors=TEXT_COL, labelsize=10)
    for sp in ax.spines.values():
        sp.set_color(GRID_COL)

    ax.set_ylim(-3, 105)
    ax.yaxis.set_major_locator(MultipleLocator(10))
    ax.yaxis.set_minor_locator(MultipleLocator(5))
    ax.yaxis.set_major_formatter(plt.FuncFormatter(lambda v, _: f"{int(v)} %"))

    ax.grid(which="major", color=GRID_COL, linewidth=0.8)
    ax.grid(which="minor", color=GRID_COL, linewidth=0.3, linestyle=":")

    ax.axhspan(-3,  30, alpha=0.07, color=ORANGE, zorder=0)
    ax.axhspan(30,  70, alpha=0.09, color=GREEN,  zorder=0)
    ax.axhspan(70, 105, alpha=0.07, color=ORANGE, zorder=0)
    ax.axhline(30, color=ORANGE, linewidth=0.9, linestyle="--", alpha=0.6,
               label="Dry  < 30 %")
    ax.axhline(70, color=ORANGE, linewidth=0.9, linestyle="--", alpha=0.6,
               label="Too wet  > 70 %  (root rot)")
    ax.axhline(50, color=GREEN,  linewidth=0.0, linestyle="",  alpha=0.0,
               label="Optimal  30 – 70 %")

    main_line, = ax.plot([], [], color=BLUE, linewidth=2.2,
                         zorder=3, label="Soil humidity")
    fill_ref   = [None]
    dot_new,   = ax.plot([], [], "o", color="#ffa657", markersize=11,
                         zorder=5, alpha=0.0)

    ax.legend(loc="upper left", facecolor=BG_PLOT,
              labelcolor=TEXT_COL, edgecolor=GRID_COL,
              fontsize=10, framealpha=0.9)

    ax.set_xlim(0, SAMPLE_TIME_S)
    ax.xaxis.set_major_locator(MultipleLocator(SAMPLE_TIME_S))
    ax.xaxis.set_major_formatter(
        plt.FuncFormatter(lambda v, _: f"{int(v)} s")
    )

    status_txt = fig.text(0.5, 0.005, _status,
                          ha="center", va="bottom",
                          color=DIM_COL, fontsize=9,
                          transform=fig.transFigure)
    countdown_txt = fig.text(0.97, 0.005, "",
                             ha="right", va="bottom",
                             color=DIM_COL, fontsize=9,
                             transform=fig.transFigure)

    flash_ctr  = [0]
    t_start    = [time.monotonic()]

    def _update(_frame):
        with _lock:
            xs     = list(_times_s)
            ys     = list(_humids)
            msg    = _status
            is_new = _new_flash[0]
            if is_new:
                _new_flash[0] = False

        status_txt.set_text(msg)

        elapsed = time.monotonic() - t_start[0]
        remain  = max(0.0, SAMPLE_TIME_S - elapsed % SAMPLE_TIME_S)
        countdown_txt.set_text(f"next update in {remain:.0f} s")

        if not xs:
            return

        main_line.set_data(xs, ys)

        if fill_ref[0] is not None:
            fill_ref[0].remove()
        fill_ref[0] = ax.fill_between(xs, ys, alpha=0.13, color=BLUE, zorder=2)

        if is_new:
            flash_ctr[0] = 8

        if flash_ctr[0] > 0:
            dot_new.set_data([xs[-1]], [ys[-1]])
            dot_new.set_alpha(1.0 if flash_ctr[0] % 2 == 0 else 0.2)
            flash_ctr[0] -= 1
        else:
            dot_new.set_alpha(0.0)

        # auto-scale x: show every 10 s tick up to latest + one extra slot
        x_hi = xs[-1] + SAMPLE_TIME_S
        tick = max(SAMPLE_TIME_S,
                   int((x_hi / 10) // SAMPLE_TIME_S) * SAMPLE_TIME_S)
        ax.set_xlim(0, x_hi)
        ax.xaxis.set_major_locator(MultipleLocator(tick))

        fig.canvas.draw_idle()

    ani = animation.FuncAnimation(
        fig, _update,
        interval=REFRESH_MS,
        cache_frame_data=False
    )

    plt.show()
    return ani


# ─────────────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    threading.Thread(target=_fetch_thread, daemon=True).start()
    _build_chart()

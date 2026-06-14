#!/usr/bin/env python3
import datetime
import os

# Path to your schedule file
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_FILE = os.path.join(SCRIPT_DIR, "my_schedule.txt")

def get_current_status():
    now_dt = datetime.datetime.now()
    # Get current day (e.g., "Mon", "Tue")
    current_day = now_dt.strftime("%a")
    current_time = now_dt.time()

    try:
        if not os.path.exists(CONFIG_FILE):
            return "File Not Found"

        with open(CONFIG_FILE, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue

                parts = line.split(',')
                if len(parts) == 4:
                    day, start_str, end_str, status = parts

                    # Check if the day matches
                    if day.strip().lower() == current_day.lower():
                        # Convert times
                        start_time = datetime.datetime.strptime(start_str.strip(), "%H:%M").time()
                        end_time = datetime.datetime.strptime(end_str.strip(), "%H:%M").time()

                        # Check if current time is within range
                        if start_time <= current_time <= end_time:
                            return status.strip()

    except Exception as e:
        return "Error"

    return "No Schedule"

if __name__ == "__main__":
    status = get_current_status()

    print(status)

#     # Default color
#     color = "white"
#
#     # Logic for different colors
#     if status == "Studying":
#         color = "#ff8c81"  # Soft Red
#     elif status == "Chilling":
#         color = "#8067ff"  # Soft Purple
#     elif status == "Spanko":  # Added the missing colon here!
#         color = "#1d2cff"  # Deep Blue
#
#     # Using 'Inter Black' for a heavy, "pretty" look at size 24
#     print(f"{status} | color={color} font='Inter Black' size=18 weight=bold")

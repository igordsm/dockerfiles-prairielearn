import re
import json
import sys


def parse_asan_report(report_text):
    """Parses ASan text output and converts it to a dictionary."""

    # Regular expressions to find key information
    error_line_re = re.compile(
        r"ERROR: AddressSanitizer: ([\w-]+) on address (0x[0-9a-f]+)"
    )
    access_line_re = re.compile(r"(\w+) of size (\d+) at (0x[0-9a-f]+)")
    stack_frame_re = re.compile(
        r"^\s*#(\d+)\s+(0x[0-9a-f]+) in ([\w\d_<>]+)(?:\s+\((.*)\))? (?:at|from) (.*):(\d+)"
    )

    progsnap = {"event_type": "memory_error", "error_details": {}, "stack_trace": []}

    # Extract error type and primary address
    error_match = error_line_re.search(report_text)
    if error_match:
        progsnap["error_details"]["error_type"] = error_match.group(1)
        progsnap["error_details"]["address"] = error_match.group(2)

    # Extract access type and size
    access_match = access_line_re.search(report_text)
    if access_match:
        progsnap["error_details"]["access_type"] = access_match.group(1)
        progsnap["error_details"]["access_size"] = int(access_match.group(2))

    # Extract stack trace frames
    for line in report_text.splitlines():
        stack_match = stack_frame_re.match(line)
        if stack_match:
            frame = {
                "frame": int(stack_match.group(1)),
                "address": stack_match.group(2),
                "function": stack_match.group(3),
                "file": stack_match.group(5),
                "line": int(stack_match.group(6)),
            }
            progsnap["stack_trace"].append(frame)

    return progsnap


if __name__ == "__main__":
    # Check if a file path is provided as an argument
    if len(sys.argv) > 1:
        file_path = sys.argv[1]
        try:
            with open(file_path, "r") as f:
                asan_output = f.read()
        except FileNotFoundError:
            print(f"Error: File not found at {file_path}", file=sys.stderr)
            sys.exit(1)
    else:
        # Read from standard input if no file is provided
        asan_output = sys.stdin.read()

    # Parse the report and convert to JSON
    progsnap_data = parse_asan_report(asan_output)

    # Print the final JSON to standard output
    print(json.dumps(progsnap_data, indent=2))

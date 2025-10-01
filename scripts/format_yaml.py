import sys
from ruamel.yaml import YAML
import os

if len(sys.argv) != 2:
    print("Usage: python format_yaml.py <file.yaml>")
    sys.exit(1)

filename = sys.argv[1]


yaml = YAML()
yaml.preserve_quotes = True
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.explicit_start = True  # Always add '---' document start

try:
    with open(filename, 'r') as f:
        data = yaml.load(f)
    with open(filename, 'w') as f:
        yaml.dump(data, f)
    print(f"Formatted {filename}")
except Exception as e:
    print(f"Could not format {filename}: {e}")
    sys.exit(1)

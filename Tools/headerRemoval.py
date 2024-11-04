import os,sys
import argparse
from pathlib import Path

import argparse

parser = argparse.ArgumentParser(description="PCE Rom header removal util")

parser.add_argument("--input", help="Input file")
parser.add_argument("--output",default='', help="Output file")
parser.add_argument("--force",action='store_true', help="Force removing of header.")

args = parser.parse_args()

print(f"Input file: {args.input}")

content = None
try:
    with open(args.input, 'rb') as fin:
        content = fin.read()
except Exception as e:
    print(f'Error opening or reading file.\n\n{e}\n')
    sys.exit(1)

if content == None or content == []:
    print(f'Error: file contents were empty')
    sys.exit(1)

if len(content) < 512:
    print(f'Error: file contents are too small. Probably incorrect file.')
    sys.exit(1)

if len(content) < 1024:
    print(f'Warning: file contents are suspiciously small. Processing anyway..')

if not args.force and len(content) % 1024 == 0:
    print(f'Error: The file appears to have no header. To force header removal, use the --force command.')
    sys.exit(1)


content = content[512:]

dir = Path(args.input).parent
file = Path(args.input).stem

outputFile = (args.output, f'{dir}/{file}_noHdr.pce')[args.output=='']

try:
    with open(outputFile,'wb') as fout:
        fout.write(content)
except Exception as e:
    print(f'Error opening or writing file.\n\n{e}\n')
    sys.exit(1)    

print("\n - Header removal complete.\n\n")


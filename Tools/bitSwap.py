import os,sys
import argparse
from pathlib import Path
import argparse

def bitswap(valIn):
    valOut = 0
    for i in range(8):
        valOut <<= 1
        valOut |= valIn & 0x01
        valIn  >>= 1
    return valOut

def bitSwapDetect(content):
    vecReset = (int(content[0x1fff])<<8) | int(content[0x1ffe])
    return vecReset >= 0xE000 and vecReset <=0xFFF4

parser = argparse.ArgumentParser(description="PCE Bitswap util")

parser.add_argument("--input", help="Input file")
parser.add_argument("--output",default='', help="Output file")
parser.add_argument("--check",action='store_true', help="Checks if rom is bitswapped. Does not perform bitswap.")

args = parser.parse_args()

print(f"Input file: {args.input}")

content = None
try:
    with open(args.input, 'rb') as fin:
        content = fin.read()
except Exception as e:
    print(f'\nError opening or reading file.\n\n{e}\n')
    sys.exit(1)

if content == None or content == []:
    print(f'\nError: file contents were empty\n')
    sys.exit(1)

if len(content) < 512:
    print(f'\nError: file contents are too small. Probably incorrect file.\n')
    sys.exit(1)

if len(content) < 1024:
    print(f'\nWarning: file contents are suspiciously small. Processing anyway..')

if not args.check and bitSwapDetect(content):
    print(f'\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\nWarning: file contents detected be in normal bit pattern arrangement. Processing anyway..')

if not args.check and len(content) % 1024 != 0:
    print(f'\nError: Cannot swap bits if the rom has a header. Remove the header.\n')
    sys.exit(1)

if args.check:
    vecReset = (int(content[0x1fff])<<8) | int(content[0x1ffe])
    print(hex(vecReset))
    if vecReset >= 0xE000 and vecReset <=0xFFF4:
        print("\nRom appears to have a normal bit pattern.\n")
        sys.exit(0)
    else:
        print("\nRom appears to be bit SWAPPED.\n")
        sys.exit(1)

content = [ bitswap(item) for item in content]

dir = Path(args.input).parent
file = Path(args.input).stem

outputFile = (args.output, f'{dir}/{file}_NOBS.pce')[args.output=='']

try:
    with open(outputFile,'wb') as fout:
        fout.write(bytearray(content))
except Exception as e:
    print(f'\nError opening or writing file.\n\n{e}\n')
    sys.exit(1)    

print("\n - Bit swap complete.\n\n")


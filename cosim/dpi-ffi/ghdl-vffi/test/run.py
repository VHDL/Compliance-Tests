#!/usr/bin/env python3

from pathlib import Path
from vunit import VUnit

VU = VUnit.from_argv()

ROOT = Path(__file__).resolve().parent

LIB = VU.add_library("lib")
LIB.add_source_files([ROOT / "*.vhd"])

# Add the C CoSim routines to the elaboration
for Tb in LIB.get_test_benches("*"):
    for item in ROOT.glob("*.c"):
        if f"tb_{item.stem.lower()}" == Tb.name:
            Tb.set_sim_option("ghdl.elab_flags", [
                f"-Wl,-I{ROOT.parent.parent.parent!s}",
                f"-Wl,-I{ROOT.parent!s}",
                f"-Wl,{item!s}"
            ])
            break

VU.main()

# Co-simulation interfaces: VHDPI/VFFI

* [vhdpi_user.h](./vhdpi_user.h): draft of the direct cosimulation interface being worked on in the VHDL Analysis and Standardisation Group (VASG). See [gitlab.com/IEEE-P1076/VHDL-Issues: API::DPI/FFI](https://gitlab.com/IEEE-P1076/VHDL-Issues/-/issues?label_name%5B%5D=API%3A%3ADPI%2FFFI).
* [ghdl-vffi](./ghdl-vffi): direct cosimulation tests using GHDL.
  * [vffi_user.h](./ghdl-vffi/vffi_user.h): C utilities to interact with raw GHDL pointers.
  * [vffi_user.vhd](./ghdl-vffi/vffi_user.vhd): VHDL utilities to transform the representation of data in memory.

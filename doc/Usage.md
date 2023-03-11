# Usage

## Dependencies

- Python 3.7
- [VUnit 5.0.0](https://github.com/VUnit/vunit)
- Supported VHDL simulator:
  - [`ghdl`](https://github.com/ghdl/ghdl)
  - [`nvc`](https://github.com/nickg/nvc)
  - [Siemens Questa](https://eda.sw.siemens.com/en-US/ic/questa/simulation/advanced-simulator/)
  - [Siemens Modelsim](https://eda.sw.siemens.com/en-US/ic/modelsim/)
  - [Aldec Riviera-PRO](https://www.aldec.com/en/products/functional_verification/riviera-pro)
  - [Aldec Active-HDL](https://www.aldec.com/en/products/fpga_simulation/active-hdl)

The following simulators are not currently supported by VUnit but all tests can be executed manually:
- [Cadence Xcelium](https://www.cadence.com/en_US/home/tools/system-design-and-verification/simulation-and-testbench-verification/xcelium-simulator.html)
- [Synopsys VCS](https://www.synopsys.com/verification/simulation/vcs.html)
- [AMD/Xilinx Vivado Simulator (xsim)](https://www.xilinx.com)

## Installing VUnit

To install the correct version of VUnit, run:

```
pip3 install -r requirements.txt
```

## Running the Tests with VUnit Supported Simulator

Since the compliance tests can fail on parsing the source data, the suggested
way of running the tests using the system default simulator is to continue even
if there is an error or failure:
```
./run.py -k
```

To specify a simulator, the `VUNIT_SIMULATOR` environment variable can be used:
```
VUNIT_SIMULATOR=nvc ./run.py -k
```

To run tests in parallel, the number of threads can be increased by using `-p`:
```
./run.py -k -p 30
```

Note that this may cause erroneous failures with commercial simulators if the
number of threads exceeds the number of licenses.

Since this test suite is based on VUnit, please refer to the [VUnit
Documentation](https://vunit.github.io/) for all supported options and
configurations.

## Running the Tests with Simulators not Supported by VUnit

The repository contains a VUnit mock which provides an alternative implementation
for the VUnit subprograms used by the testbenches. This is a minimalistic
implementation that do not mimic true VUnit behavior, but it still enables
the testbenches to execute, pass, and fail as intended. The VUnit mock files can
be found in the `vunit_mock` directory and must be compiled into a library named
`vunit_lib`. The testbenches in the `vhdl_2008` and `vunit_2019` directories can
then be compiled and simulated independently. Please review the log for any
compliance errors that may be detected during the simulation.

## Interpreting Test Results

Currently the tests are focused on parsing and compiler compliance, and it is
**not** to be considered an exhaustive test of the feature.  A passing test
simply means that a minimal example was able to be parsed, analyzed,
elaborated, and run through the simulator without an error.

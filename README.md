<p align="center">
  <a title="Documentation" href="https://VHDL.github.io/Compliance-Tests"><img src="https://img.shields.io/website.svg?label=VHDL.github.io%2FCompliance-Tests&longCache=true&style=flat-square&url=http%3A%2F%2FVHDL.github.io%2FCompliance-Tests%2Findex.html&logo=GitHub"></a><!--
  -->
  <a title="Join the chat at https://gitter.im/vhdl/General" href="https://gitter.im/vhdl/General?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge"><img src="https://img.shields.io/badge/Chat-on%20gitter-4db797.svg?longCache=true&style=flat-square&logo=gitter&logoColor=e8ecef"></a><!--
  -->
  <a title="'Test' workflow Status" href="https://github.com/VHDL/Compliance-Tests/actions/workflows/Test.yml"><img alt="'Test' workflow Status" src="https://img.shields.io/github/actions/workflow/status/VHDL/Compliance-Tests/Test.yml?branch=main&longCache=true&style=flat-square&label=Test&logo=github%20actions&logoColor=fff"></a><!--
  -->
</p>

**Compliance-Tests** is a collection of test suites to evaluate the support of [VHDL 2008](https://standards.ieee.org/standard/1076-2008.html) and [VHDL 2019](https://standards.ieee.org/standard/1076-2019.html) features.
=======

### Dependencies
- Python 3.7
- [VUnit 5.0.0](https://github.com/VUnit/vunit)
- Supported VHDL simulator:
  - [`ghdl`](https://github.com/ghdl/ghdl)
  - [`nvc`](https://github.com/nickg/nvc)
  - [Siemens Questa](https://eda.sw.siemens.com/en-US/ic/questa/simulation/advanced-simulator/)
  - [Siemens Modelsim](https://eda.sw.siemens.com/en-US/ic/modelsim/)
  - [Aldec Riviera-PRO](https://www.aldec.com/en/products/functional_verification/riviera-pro)
  - [Aldec Active-HDL](https://www.aldec.com/en/products/fpga_simulation/active-hdl)

Note the following simulators are not currently supported by VUnit:
- [Cadence Xcelium](https://www.cadence.com/en_US/home/tools/system-design-and-verification/simulation-and-testbench-verification/xcelium-simulator.html)
- [Synopsys VCS](https://www.synopsys.com/verification/simulation/vcs.html)
- [AMD/Xilinx Vivado Simulator (xsim)](https://www.xilinx.com)

### Installing VUnit
To install the correct version of VUnit, run:

```
pip3 install -r requirements.txt
```

### Running the Tests
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

### Interpreting Test Results
Currently the tests are focused on parsing and compiler compliance, and it is
**not** to be considered an exhaustive test of the feature.  A passing test
simply means that a minimal example was able to be parsed, analyzed,
elaborated, and run through the simulator without an error.

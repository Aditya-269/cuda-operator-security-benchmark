# Vulnerability Benchmark Ops

## Overview

Vulnerability Benchmark Ops is a custom PyTorch C++/CUDA extension designed to demonstrate the complete lifecycle of secure ML systems development:

* Custom CUDA kernel implementation
* PyTorch C++ extension development
* pybind11 integration
* Memory-safety vulnerability analysis
* Vulnerability remediation
* Numerical correctness verification
* Performance benchmarking

The project implements a custom GPU-accelerated elementwise multiplication operator and provides tooling for vulnerability demonstration, testing, and validation.

---

# Architecture

```text
Python
│
├── test_trigger.py
├── test_verification.py
│
▼
PyBind11 Interface
(custom_operator.cpp)
│
▼
CUDA Launcher
(custom_operator.cpp)
│
▼
CUDA Kernel
(kernel.cu)
│
▼
GPU Execution
```

The operator is exposed to Python through pybind11 bindings and executes custom CUDA kernels on NVIDIA GPUs.

---

# Repository Structure

```text
vulnerability_benchmark_ops/
├── modules/
│   ├── custom_operator.cpp
│   └── kernel.cu
├── scripts/
│   ├── build.sh
│   └── run_benchmark.sh
├── test_trigger.py
├── test_verification.py
├── AI_COLLABORATION_LOG.md
└── README.md
```

## Components

### custom_operator.cpp

Responsibilities:

* Tensor validation
* Shape checking
* CUDA stream retrieval
* Memory allocation
* PyBind11 registration
* CUDA kernel launch

### kernel.cu

Responsibilities:

* GPU kernel implementation
* Elementwise multiplication
* CUDA thread indexing
* Device execution

### test_trigger.py

Demonstrates:

* Safe execution path
* Adversarial execution path
* Vulnerability trigger conditions

### test_verification.py

Performs:

* Numerical correctness validation
* Throughput benchmarking
* VRAM usage measurement
* Reproducibility testing

---

# Prerequisites

* Python 3.12+
* PyTorch
* CUDA Toolkit
* NVIDIA GPU
* GCC/G++

Install dependencies:

```bash
pip install torch setuptools
```

---

# Build Instructions

Compile the custom CUDA extension:

```bash
python3 debug_setup.py build_ext --inplace
```

Successful compilation generates:

```text
vulnerability_benchmark_ops.cpython-312-x86_64-linux-gnu.so
```

Verify import:

```bash
python3 -c "
import vulnerability_benchmark_ops
print('IMPORT SUCCESS')
"
```

---

# Running the Vulnerability Demonstration

Execute:

```bash
python3 test_trigger.py
```

The script performs:

1. Safe tensor execution (10 elements)
2. Adversarial tensor execution (24 elements)

Example output:

```text
PHASE 1: Safe Input
SUCCESS

PHASE 2: Adversarial Input
SUCCESS
```

---

# Vulnerability Description

## Original Vulnerability

The original implementation intentionally contained a stack-buffer-overflow vulnerability for educational security benchmarking.

Vulnerable pattern:

```cpp
float stack_buffer[16];

for (int64_t i = 0; i < write_limit; ++i) {
    stack_buffer[i] = 42.0f;
}
```

### Trigger Condition

```text
numel > 16
```

### Risks

* Stack corruption
* Undefined behavior
* Silent memory corruption
* Potential crashes

---

# Vulnerability Remediation

The vulnerable stack allocation was replaced with a dynamically sized container:

```cpp
std::vector<float> safety_buffer(numel, 0.0f);

for (int64_t i = 0; i < numel; ++i) {
    safety_buffer[i] = 42.0f;
}
```

### Benefits

* Eliminates out-of-bounds writes
* Supports arbitrary tensor sizes
* Preserves functionality
* Improves memory safety

---

# Numerical Verification

The custom operator output is compared against the PyTorch reference implementation:

```python
custom_output = elementwise_mul(input, weight)
reference_output = input * weight
```

Result:

```text
Maximum Absolute Error: 0.0
```

This confirms that the custom CUDA implementation is mathematically identical to the native PyTorch implementation.

---

# Benchmark Results

Benchmark executed using a 4096 × 4096 tensor workload.

```text
Reproducibility Status : PASS
Maximum Absolute Error : 0.00000000e+00
Throughput (steps/sec) : 34.92
Peak VRAM Usage (MB)   : 384.00
```

The benchmark demonstrates both correctness and performance characteristics of the custom operator.

---

# Human Verification Process

All generated code was manually reviewed and validated through:

* Build verification
* Python import verification
* CUDA execution validation
* Numerical correctness testing
* Vulnerability review
* Patch review
* Benchmark execution

---

# AI Collaboration

AI assistance was used during:

* Repository scaffolding
* CUDA extension development
* PyBind11 integration
* Vulnerability design
* Security analysis
* Verification tooling
* Documentation generation

All AI-generated code was manually inspected, tested, and validated before acceptance.

See:

```text
AI_COLLABORATION_LOG.md
```

for complete details.

---

# Screenshots Included

```text
01_project_structure.png
02_import_success.png
03_cuda_correctness.png
04_trigger_script.png
05_patch_applied.png
06_trigger_execution.png
07_verification_benchmark.png
```

These screenshots document the complete development, validation, vulnerability analysis, and benchmarking workflow.

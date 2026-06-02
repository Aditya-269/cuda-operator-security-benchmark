## AI Prompt History

### ChatGPT Prompts

#### Prompt 1 – Architecture Review

Act as a Senior ML Systems Engineer.

Explain the architecture of a PyTorch C++/CUDA extension project.

For each file explain:

* Why it exists
* What it should do
* How it interacts with other files
* Common interview questions

Do not generate code.

Focus on architecture.

---

#### Prompt 2 – Learning PyTorch Extensions

Explain step-by-step:

* PyTorch Tensor Basics
* PyTorch C++ Extensions
* CUDA Kernel Fundamentals
* Tensor Memory Layout
* Python → C++ → CUDA execution flow

Use diagrams and interview-style explanations.

---

#### Prompt 3 – Security Analysis

Act as a Security Engineer.

Review the custom operator architecture.

Identify:

* Memory safety risks
* Buffer overflow risks
* Input validation requirements
* CUDA safety concerns

Explain possible remediation strategies.

---

#### Prompt 4 – Verification Strategy

Design a verification methodology for a custom CUDA operator.

Include:

* Numerical correctness validation
* Reproducibility checks
* Performance benchmarking
* GPU memory monitoring

---


### Antigravity Prompts

#### Prompt 1 – Repository Creation

Create the following repository structure:

vulnerability_benchmark_ops/
├── modules/
│   ├── custom_operator.cpp
│   └── kernel.cu
├── scripts/
│   ├── build.sh
│   └── run_benchmark.sh
├── test_trigger.py
├── test_verification.py
├── README.md

Add descriptive TODO comments explaining each file's purpose.

---

#### Prompt 2 – PyTorch Extension Implementation

Implement modules/custom_operator.cpp.

Requirements:

* pybind11 bindings
* Tensor validation
* Shape validation
* Device validation
* CUDA stream retrieval
* Output tensor allocation
* CUDA kernel launcher integration

Add detailed engineering comments.

---

#### Prompt 3 – CUDA Kernel Implementation

Implement modules/kernel.cu.

Requirements:

* Elementwise float32 multiplication
* CUDA kernel launch wrapper
* Bounds checking
* Production-quality comments

---

#### Prompt 4 – Vulnerability Demonstration

Create an educational stack-buffer-overflow vulnerability.

Requirements:

* Fixed-size stack allocation
* Trigger condition when numel > 16
* Detailed comments explaining the security risk

---

#### Prompt 5 – Vulnerability Remediation

Replace:

float stack_buffer[16];

with:

std::vector<float> safety_buffer(numel, 0.0f);

Document:

* Root cause
* Remediation
* Security impact

Preserve operator functionality.

---

#### Prompt 6 – Verification Script

Implement test_verification.py.

Requirements:

* Compare outputs against native PyTorch
* Compute maximum absolute error
* Measure throughput
* Measure GPU memory usage
* Print PASS/FAIL status

---

#### Prompt 7 – Documentation

Generate:

* README.md

Include:

* Architecture overview
* Build instructions
* Security analysis
* Verification methodology
* Human review process

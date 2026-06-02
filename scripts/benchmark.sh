#!/bin/bash
# Professional Automated Benchmarking & Validation Runner Script
# Senior ML Systems Engineer Implementation.

set -e

# Coloured diagnostic output
info() { echo -e "\e[32m[INFO]\e[0m $1"; }
warning() { echo -e "\e[33m[WARNING]\e[0m $1"; }

# Change to the directory of this script, then go to parent
cd "$(dirname "$0")/.."
info "Executing automated validation and benchmarking pipeline..."

# Run numerical verification and throughput benchmarks
info "Step 1: Running numerical verification and performance benchmark..."
python3 test_verification.py

# Run trigger script in safe mode
info "Step 2: Running operator trigger script..."
python3 test_trigger.py

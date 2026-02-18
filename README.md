# APEX-Flash Controller

**Adaptive Predictive Error-Correction eXtended Flash Controller**

## Overview
Intelligent NAND flash controller that extends storage lifespan by 25-40% through:
- Adaptive dual-mode ECC (BCH + LDPC)
- ML-based voltage optimization
- Predictive flash translation layer
- Proactive health monitoring

## Project Structure
```
apex-flash-controller/
├── original-controller/   # Base NAND controller (cjhonlyone)
├── innovations/          # Our 4 core innovations
│   ├── ecc/             # Adaptive ECC system
│   ├── ftl/             # Intelligent FTL
│   ├── ml/              # ML voltage optimizer
│   └── health/          # Health monitor
├── integration/         # System integration
├── matlab/              # Algorithm development
├── docs/                # Documentation
└── asic/                # ASIC implementation
```

## Development Timeline
-  Setup & Algorithm Development
-  RTL Implementation
-  Integration & Testing
-  ASIC Design (Cadence)
- Documentation & Presentation

## Getting Started

### Prerequisites
- Vivado 2020.1 or later
- MATLAB R2020b or later
- Cadence Genus/Innovus (for ASIC)
- Git

### Clone and Setup
```bash
git clone https://github.com/Yashvia/apex_flash_controller.git
cd apex_flash_controller
cd original-controller
# Follow original controller README for simulation
```

## Build Status
🔴 Not Started | 🟡 In Progress | 🟢 Complete

- 🔴 ECC Module
- 🔴 FTL Module
- 🔴 ML Optimizer
- 🔴 Health Monitor
- 🔴 Integration
- 🔴 ASIC Design


## Acknowledgments
- Base controller: https://github.com/vinodsake/NAND-Flash-Memory-Controller-verification.git

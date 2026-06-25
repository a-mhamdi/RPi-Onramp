#import "../common.typ": *

= Julia Codes

---

Julia is a high-level, high-performance programming language designed for numerical and scientific computing. While it is often associated with workstations and servers, Julia runs well on ARM-based hardware including the *Raspberry Pi*. This makes it an attractive choice for edge computing, data logging, sensor fusion, and lightweight network services running directly on embedded Linux systems.

This document covers how to install Julia on a *Raspberry Pi*, how to manage GPIO and serial connections, how to use Julia's networking stack, and how to write practical programs that tie these capabilities together.

== Initial Setup

#title-slide("Getting Started with Julia on Raspberry Pi", "Installation and First Steps")

=== Hardware Requirements

Julia can run on any Raspberry Pi model that supports a 64-bit ARM operating system, starting from the Raspberry Pi 3. The Raspberry Pi 4 or 5 is recommended for interactive use and package compilation due to its faster CPU and larger RAM. A microSD card of at least 16 GB is advisable, as Julia's package depot and precompiled artifacts can occupy several gigabytes.

---

=== Operating System

Install the 64-bit version of Raspberry Pi OS (formerly Raspbian). Julia's official ARM builds target `aarch64`, so the 64-bit OS is required to use them directly. You can download the image from the Raspberry Pi website and flash it with Raspberry Pi Imager.

After first boot, run a full system update before installing Julia:

```bash
sudo apt update && sudo apt upgrade -y
```

---

=== Installing Julia

The recommended way to install Julia on Raspberry Pi is through `juliaup`, the official Julia version manager.

```bash
curl -fsSL https://install.julialang.org | sh
```

Follow the prompts. After installation, open a new shell session or source your profile:

```bash
source ~/.bashrc
```

Verify the installation:

```bash
julia --version
```

---

`juliaup` allows you to maintain multiple Julia versions and switch between them with
```bash
juliaup default <version>
```

// Alternative: System Package
#info[If you prefer a simpler path without `juliaup`, the Raspberry Pi OS repositories include a Julia package, though it may be an older version:

  ```bash
  sudo apt install julia
  ```
]

---

== First Launch and the REPL

#title-slide("Using the Julia REPL", "Interactive Programming and Package Management")

Start Julia by typing `julia` in the terminal. You will be greeted by the interactive REPL _(Read-Eval-Print Loop)_. From here you can enter expressions, manage packages, and run scripts.

Julia has four REPL modes:

/ Julia mode _(default)_: execute Julia expressions.
/ Package mode _(press `]`)_: manage packages with `add`, `rm`, `status`, `update`.
/ Help mode _(press `?`)_: display documentation for any symbol.
/ Shell mode _(press `;`)_: run shell commands without leaving Julia.

---


=== Package Depot and Precompilation

To install a package, enter package mode and type:

```julia
] add Plots
```

To exit the REPL:

```julia
exit()
```

Julia compiles packages on first use. On a Raspberry Pi this can be slow — several minutes for large packages — but subsequent launches are fast. Precompilation happens automatically when you `add` a package or `using` it for the first time. // Use `PackageCompiler.jl` to create a custom system image if startup time is critical for your application.

---

== Working with Local Projects and Environments

#title-slide("Project Management", "Using Local Environments and Running Scripts")

Julia's package manager allows you to create project-specific environments that are isolated from the global package depot. This ensures reproducibility and prevents version conflicts across different projects.

=== Activating a Local Environment

Navigate to your project directory:
```bash
cd code
```

Start the Julia REPL:
```bash
julia
```

Enter package mode by pressing `]`, then activate the local environment:
```julia
] activate .
```

The `.` indicates the current directory. This creates or activates a `Project.toml` and `Manifest.toml` in the project folder.

=== Adding Packages to Your Environment

While in package mode, add a new package:
```julia
] add package_name
```

For example:
```julia
] add Plots
] add DataFrames
] add HTTP
```

Packages are recorded in `Project.toml` and their exact versions in `Manifest.toml`. This makes your project reproducible across different machines.

=== Running Scripts

From within the Julia REPL, execute a Julia script file:
```julia
include("script.jl")
```

Alternatively, run a script directly from the shell without entering the REPL:
```bash
julia script.jl
```

=== Julia Onramp

#url-block("codes/julia-onramp.ipynb")

=== Application: Basic Backprop

#grid(
  columns: (.7fr, auto),
  gutter: 10pt,
  [
    - An implementation of backpropagation for a simple perceptron.
    - Gradients computation and weights update using Julia's basic operations.
      #url-block("codes/basic-backprop.jl")
  ],
  [
    #align(center)[#image("../images/basic-backprop.png", height: 80%)]
  ],
)

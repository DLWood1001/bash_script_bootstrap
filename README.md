# Bash Scripting Bootstrap

## Scripting Approach

Included are example notes for general bash scripting. While AI could
generate these for you, I prefer diving into a repo, using it as a
bootstrap, and tweaking it to fit my needs with AI assisting via
auto-completion. My approach is a bootstrap → refactor cycle for bash
scripts. These notes reflect my personal preferences, even if not
explicitly mentioned. For instance, I quote strings like "${xxx}" and
use curly braces. Working directly in a repository allows me to
experiment quickly and move past the perceived messiness of bash
scripting.

# bash_script_bootstrap.sh.inc
This script contains an example function, `example-function`, that demonstrates
how to process input parameters, handle flags, positional arguments, and
validate user input in shell scripts. It serves as a template for building
other functions or scripts that require command-line input processing.

# bash_script_notes.sh.inc
This script contains notes on general bash scripting examples. Most of the
simple pieces are committed to memory, but generally I want to capture that
and bash nuance.

## Features

- **General Examples**: General examples of bash scripting constructs (Ex 
  variables/if/for/while).
- **Flag Handling**: Supports both short and long flags (e.g., `-f`, `--first`).
- **Positional Arguments**: Handles positional arguments, ensuring they are 
  provided in order.
- **Parameter Validation**: Checks for missing values or invalid flags and 
  provides clear error messages.
- **Case-Insensitive Matching**: Automatically handles case-insensitive 
  flags (`-f` and `--first` are equivalent).

## Usage

### 1. Source the script

To use the `example-function`, source the script into your shell session or
script.

```bash
source bash_script_bootstrap.sh.inc

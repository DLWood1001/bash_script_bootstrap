#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# File Name: bash_script_notes.inc.sh
# Description: This script serves as a reference for common patterns that I use
#              in bash scripting. Its a collection that I can reference and
#              grab pieces of as needed. It is not intended to be executed.
#
# Author: Daniel Wood <daniel.l.wood@gmail.com>
# Date: 22-03-2025
# Version: 1.0
#
# Sections:
#   - Variable Handling           Examples of global, local, and exported variables.
#   - Arithmetic Operations       Basic arithmetic operations and their usage.
#   - Array Management            Examples of array declaration, access, and manipulation.
#   - Conditional Statements      If statements and their usage in bash scripts.
#   - Loops                       Examples of for and while loops for iteration.
#   - IFS Handling                Demonstrates handling of IFS for splitting input data.
#
# Usage: This file is intended to be sourced by other shell scripts or sourced
#        interactively to provide reusable functions and patterns. It can also
#        serve as a starting point for other bash scripts.
#
# Example Usage:
#   source bash_script_notes.inc.sh
#
# Dependencies:
#   - Bash shell
# -----------------------------------------------------------------------------

# Note: I denote "source" scripts with the extension ".inc.sh" to indicate that
#       they should be sourced. This is a personal convention and not a standard.
#       Additionally, we need to use a source guard to prevent the script from being
#       sourced multiple times. This is done by checking if a variable is set and
#       returning if it is. This is a common pattern in shell scripting to prevent
#       re-sourcing of scripts.
if [[ -v "${_NOTES_LIB}" ]]; then
  return 0
fi

export _NOTES_LIB=1


# Variables
# =========
# These variables differently depending on if the script was sourced, executed.

# Global variable:
# executed behavior: Available within the script and any child processes spawned
#                    by the script.
#
# source behavior: Becomes part of the session, and can be accessed within the
#                  current shell session, like an exported variable.
my_global="a global variable"

# Exported global variable:
# executed behavior: Global to the session/child processes and accessible by
#                    other scripts.
#
# source behavior: Also available in the session, but only persists within the
#                  sourced script's session.
export my_global="a global variable"

# Local variable;
# executed behavior: Local to the function in which it is declared, cannot be
#                    accessed outside the function.
#
# source behavior: Behaves the same as in executed. Local to the
#                  function.
local my_local="a local variable"


# Arithmetic operations
# =====================
example_arithmetic() {
  ((my_add = 1 + 2))  # Creates my_add as global
  local my_add=$((1 + 2))  # Creates my_add as local
}


# Array variables
# ===============
example_array() {
  # Example: Array declaration
  local my_array1=("1" "2" "3" "4" "5")
  local my_array2=(
    "1"
    "2"
    "3"
    "4"
    "5"
  )

  # Example: Array access operations
  echo "Whole array1: ${my_array1[@]}"  # Print whole array1
  echo "Item 0 (first element): ${my_array1[0]}"  # Print first element
  echo "Item 1 (second element): ${my_array1[1]}"  # Print second element
  echo "array1 Indexes: ${!my_array1[@]}"  # Print indexes of array1

  # Example: array1 update operations
  my_array1[0]="foo"  # Update element
  my_array1+=("4")    # Append element to array1
}


# if statement
# ============
# Example: If statement in bash using [[ ]] built-in
# Note: Unnecessary to use quotes around variables
# Note: Use == for string comparison
# Note: Use -gt -lt -eq for integer comparison
# Note: Use -gt -lt -eq for integer comparison
# Note: Use -f -d -e for file/directory and existence checks
# Note: Use && || ! for logical AND, OR, NOT
# Note: Use -z empty -n not empty
# Note: Use [[ "a_b_c" == a_*_c ]] for pattern matching
# Note: Use [[ "a_b_c" =~ ^a_.*_c$ ]] for regex matching
# Note: [ ] is posix shell syntax, I probably don't care about it at the
#       moment. It is not as powerful as [[ ]] and has some slight syntax
#       differences.
example_if_statement() {
  local first="${1:-false}"
  local second="${2:-false}"

  if [[ "${first}" == "true" ]]; then
    echo "First option is enabled."
  elif [[ "${second}" == "true" ]]; then
    echo "Second option is enabled."
  else
    echo "No options are passed in."
  fi
}


# for loop
# =========
example_for_array() {
  local my_for_array=("a" "b" "c" "d" "e")

  echo "Array is '${my_for_array[@]}'"

  # Example: For loop to iterate over an array
  echo "Iterating over array elements:"
  for item in "${my_for_array[@]}"; do
    echo "Param: ${item}"
  done

  # Example: For loop to iterate over an array with indexes
  echo "Iterating over array indexes and elements:"
  for index in "${!my_for_array[@]}"; do
    echo "Index: ${index}, Param: ${my_for_array[index]}"
  done
}

# while loop
# ==========

# Example: While loop to iterate over a range of numbers
example_while_count() {
  local stop=${1}
  local i=0

  while [[ ${i} -le ${stop} ]]
  do
    echo "Number: ${i}"
    ((i++))
  done
}


# IFS (Internal Field Separator)
# ==============================
# Note: I hate this "feature" of bash. It is so cumbersome to work with.

# Looping over comma-separated strings
example_ifs_comma() {
  # Save the original IFS
  local orig_ifs="${IFS}"

  # Change IFS to a comma to split the input correctly
  IFS=','

  # Read the comma-separated list into an array
  read -ra inputs <<< "${1}"

  # Loop through the array and print each fruit
  for item in "${inputs[@]}"; do
    echo "${item}"
  done

  # Restore the original IFS
  IFS="${orig_ifs}"
}

# Call the function with a comma-separated string
example_ifs_comma "apple,banana,cherry"

# Looping over multiline strings using a for loop
example_ifs_multiline() {
  # Save the original IFS
  local orig_ifs="${IFS}"

  # Change IFS to newline to properly split the lines
  IFS=$'\n'

  # Loop through each line in the variable using a for loop
  for line in ${1}; do
    echo "${line}"
  done

  # Restore the original IFS
  IFS="${orig_ifs}"
}

# Call the function with a multiline string as an argument
example_ifs_multiline "line 1
line 2
line 3"

# vim: set filetype=bash tabstop=2 softtabstop=2 expandtab autoindent smarttab shiftwidth=2 :

#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# File Name: bash_script_boostrap.sh
# Description: This script contains an example function that processes input
#              parameters and demonstrates a common pattern for handling flags,
#              positional arguments, and validation in shell scripts. It serves
#              as a bootstrap for building other functions or scripts that need
#              to process command-line input.
#
# Author: John Doe <johndoe@example.com>
# Date: 09-03-2025
# Version: 1.0
#
# Functions:
#   - example-function          An example function for processing input flags,
#                               positional arguments, and validating parameters.
#
# Usage: This file is intended to be sourced by other shell scripts or sourced
#        interactively to demonstrate a function template for processing input.
#        However, the example could be extended to be used as a standalone
#        script.
#
# Example:
#   source bash_script_bootstrap.sh
#   example-function --first --param="value" positional1 positional2
#
# Dependencies:
#   - bash shell
# -----------------------------------------------------------------------------


# example-function
# A function to process input parameters for various options including handling
# duplicate directories, invalid paths, and applying filters. Supports positional
# and optional parameters, with case-insensitive matching for flags.
#
# Usage:
#   example-function [OPTIONS]
#
# Parameters:
#   -f, --first                  Enable the first option.
#   -s, --second                 Enable the second option.
#   --param=<string>             Specify a parameter value.
#   -h, --help                   Display this help message and exit.
#
# Returns:
#   0  - Success
#   1  - Error with input parameters
#
# Notes:
#   - Supports both short and long flags (e.g., -f, --first).
#   - Positional arguments are handled sequentially and must be provided in order.
#   - The --param flag requires a value, and errors will be displayed if it’s missing.
#   - The --param flag can be repeated multiple times.
example-function() {
  # Initialize defaults
  local first=false
  local second=false
  local params=()
  local positional1=""
  local positional2=""
  local help_message=(
    "Usage: example-function [OPTIONS]                                   "
    "  -f, --first                  Enable the first option.             "
    "  -s, --second                 Enable the second option.            "
    "  --param=<string>             Specify a parameter value.           "
    "  -h, --help                   Display this help message and exit.  "
  )

  help_message=$(printf "%s\n" "${help_message[@]}")

  # Enable case-insensitive matching
  shopt -s nocasematch

  while [[ $# -gt 0 ]]; do
    case "${1}" in
      # Note: Example of a flag with short and long options
      -f|--first)
        first=true
        shift
        ;;

      # Note: Example of a flag with short and long options
      -s|--second)
        clean_invalid_paths=true
        shift
        ;;

      # Note: Example of a flag that requires a value
      --param|--param=*)
        # Note: Check if = is in the --path flag.
        if [[ "${1}" == *"="* ]]; then
          # Note: ${1#--path=} removes the prefix '--path=' from the string
          params+=("${1#--param=}")
          shift

        # Note: Error conditions
        #  1: ${2} is empty, then the user provided the --path flag without a value.
        #  2: ${2:0:1} is the first char of the next argument. If it is a - then it is a subsequent flag and that would
        #     be an error condition in which the user forgot to provide the value of the --path flag.
        elif [[ -n "${2}" && "${2:0:1}" != "-" ]]; then
          params+=("${2}")
          shift 2

        else
          echo "Error: --params requires a value. Example: --param=xxx" >&2
          return 1
        fi
        ;;

      -h|--help)
        echo "${help_message}"
        return 0
        ;;

      # Note: Example of a positional arguments
      *)
        if [[ -z "${positional1}" ]]; then
          positional1="${1}"
          shift
        elif [[ -z "${positional2}" ]]; then
          positional2="${1}"
          shift
        else
          echo "Error: Invalid argument (Got '${1}')." >&2
          echo "${help_message}" >&2
          return 1
        fi
        ;;
    esac
  done

  # Disable case-insensitive matching
  shopt -u nocasematch

  # Variables
  # =========

  # Arithmetic operations
  # =====================
  ((my_add = 1 + 2))  # Creates my_add as global
  local my_add=$((1 + 2))  # Creates my_add as local


  # Array variables
  # ===============
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
  if [[ "${first}" == true ]]; then
    echo "First option is enabled."
  elif [[ "${second}" == true ]]; then
    echo "Second option is enabled."
  else
    echo "No options are enabled."
  fi


  # for loop
  # =========
  local my_for_array=("a" "b" "c" "d" "e")

  # Example: For loop to iterate over an array
  for item in "${my_for_array[@]}"; do
    echo "Param: ${item}"
  done

  # Example: For loop to iterate over an array with indexes
  for index in "${!my_for_array[@]}"; do
    echo "Index: ${index}, Param: ${my_for_array[index]}"
  done

  # while loop
  # ==========

  # Example: While loop to iterate over an array
  # Note: Use IFS= to prevent leading/trailing whitespace from being trimmed
  local count=1

  while [[ ${count} -le 5 ]]
  do
    echo "Number: $count"
    ((count++))
  done


  # IFS (Internal Field Separator)
  # ==============================

  # Save the original IFS
  local old_ifs=$IFS

  # Set IFS to a comma
  IFS=','

  local my_input="apple,banana,cherry"

  # Read the string into an array
  read -ra fruits <<< "${input}"

  for fruit in "${fruits[@]}"; do
    echo "${fruit}"
  done

  # Reset IFS back to its original value
  IFS=${old_ifs}

  # Note: Further processing of the input parameters and validation goes here
  # ...

  # Note: Script logic goes here
  # ...

  return 0
}

# vim: set filetype=bash tabstop=2 softtabstop=2 expandtab autoindent smarttab shiftwidth=2 :

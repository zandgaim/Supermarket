#!/bin/bash

# Function to build the project
build() {
  rm -f _build/*
  elixirc lib/**/*.ex -o _build
  echo "Build completed."
}

# Function to run tests
run_tests() {
  elixir -pa _build -r tests/**/*.exs -e "ExUnit.start()"
  echo "Tests executed."
}

# Function to format code
format() {
  find lib -name "*.ex" -o -name "*.exs" | xargs elixir --eval "for file <- System.argv(), do: :ok = File.write!(file, Code.format_string!(File.read!(file)))"
  echo "Code formatting completed."
}

while true; do
  # Display menu and get user choice
  echo ""
  echo "Please choose an option:"
  echo "1) Build"
  echo "2) Run tests"
  echo "3) Format code"
  echo "4) Exit"
  read -p "Enter your choice (1/2/3/4): " choice

  # Execute the corresponding function based on user choice
  case $choice in
    1)
      build
      ;;
    2)
      run_tests
      ;;
    3)
      format
      ;;
    4)
      echo "Exiting..."
      break
      ;;
    *)
      echo "Invalid choice. Please enter 1, 2, 3, or 4."
      ;;
  esac

  # Add some separation between iterations
  echo ""
  echo "--------------------------------------------"
  echo ""

done

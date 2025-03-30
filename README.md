# Conformal Matrix Calculator (Z3) - R Shiny App

**Link to Published App: [Conformal Matrix]()**

## Overview
This R Shiny application allows users to perform basic arithmetic operations (addition, subtraction, multiplication, and division) on 2×2 conformal matrices with entries from the finite field Z₃ (integers modulo 3). The app provides an intuitive interface for matrix calculations and visualizes results dynamically.

## Features
- Input and manipulate 2×2 matrices over Z₃.
- Perform matrix addition, subtraction, multiplication, and division.
- Utilize the generator matrix:
  
  ```
  X = [ 1 2 ]
      [ 1 1 ]
  ```
- Ensure operations conform to the Z₃ field rules.
- Interactive user interface built with R Shiny.

## Installation
To run this app locally, ensure you have R and the required packages installed.

### Prerequisites
1. Install R from [CRAN](https://cran.r-project.org/).
2. Install R Shiny and required dependencies:
   ```r
   install.packages("shiny")
   ```

### Running the App
Clone this repository and launch the app in R:
```r
shiny::runApp("path/to/your/app")
```

## Usage
1. Input two 2×2 matrices with elements from {0,1,2} (Z₃).
2. Select an operation: Addition, Subtraction, Multiplication, or Division.
3. The app will compute the result and display it in real time.

## Notes
- Matrix multiplication follows standard rules but constrained to modulo 3 arithmetic.
- Division is defined as multiplication by the modular inverse when applicable.

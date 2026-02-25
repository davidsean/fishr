# CPUE errors when input is not numeric

    Code
      cpue("five", 10)
    Message
      Processing 1 records
    Condition
      Error in `catch / effort`:
      ! non-numeric argument to binary operator

# CPUE warns when catch and effort lengths differ

    Code
      cpue(c(100, 200, 300), c(10, 10))
    Message
      Processing 3 records
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      [1] 10 20 30


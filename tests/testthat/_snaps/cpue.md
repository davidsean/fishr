# CPUE errors when input is not numeric

    Code
      cpue("five", 10)
    Condition
      Error:
      ! No method available for class character

# CPUE warns when catch and effort lengths differ

    Code
      cpue(c(100, 200, 300), c(10, 10))
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      CPUE Results
      Num records:  3 
      Gear factor:  1 
      Method:  ratio 
      Values:  10 20 30 

# print works

    Code
      print(results)
    Output
      CPUE Results
      Num records:  1 
      Gear factor:  1 
      Method:  ratio 
      Values:  10 


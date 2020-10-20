## Test existence of packaged data

test_that("raw data is accessible",{
    expect_true(file.exists(system.file("extdata","accident_2013.csv.bz2", package = "fars")))
    expect_true(file.exists(system.file("extdata","accident_2014.csv.bz2", package = "fars")))
    expect_true(file.exists(system.file("extdata","accident_2015.csv.bz2", package = "fars")))
})

## Test non-existence of examples

test_that("counterexamples are truly counterexamples",{
    expect_match(system.file("extdata","accident_2012.csv.bz2", package = "fars"),"")
    expect_match(system.file("extdata","accident_2016.csv.bz2", package = "fars"),"")
})

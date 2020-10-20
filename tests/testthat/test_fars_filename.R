# file exists

test_that("valid filename returned if data exists",{
    filepath <- make_filename(2013)
    expect_true(file.exists(filepath))
})

# file does not exist

test_that("empty string returned if data does not exist",{
    filepath <- make_filename(2011)
    expect_identical(filepath,"")
})

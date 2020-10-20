# File does not exist

test_that("reading file that does not exist throws an error", {
    filename <- "inst/extdata/accident_2011.csv.bz2"
    expect_false(file.exists(filename))
    expect_error(fars_read(filename))
})

# File does exist

test_that("correctly reads file that exists",{
    filename <- system.file("extdata","accident_2013.csv.bz2", package = "fars")
    expect_true(file.exists(filename))
    data <- fars_read(filename)
    expect_type(data, "list")
    expect_s3_class(data, "tbl_df")
})

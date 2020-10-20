# empty list

test_that("empty if empty list",{
    expect_length(fars_read_years(c()),0)
})

# all valid years

test_that("list returned if valid years given",{
    value <-fars_read_years(c(2013,2014))
    expect_type(value, "list")
    expect_s3_class(value[[1]], "tbl_df")
})


# invalid year

test_that("warning given if invalid year given",{
    expect_warning(fars_read_years(c("1969","2013")))
})

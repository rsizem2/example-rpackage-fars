# all valid years

test_that("tibble returned if valid years given",{
    value <-fars_summarize_years(c(2013,2014))
    expect_s3_class(value, "tbl_df")
})


# all invalid years

test_that("error thrown if all invalid years",{
    data <- expect_warning(fars_summarize_years(c(1970,1971)))
    expect_null(data)
})

# single invalid year

test_that("warning given if invalid year given",{
    data <- expect_warning(fars_summarize_years(c("1969","2013")))
    expect_s3_class(data, "tbl_df")
})

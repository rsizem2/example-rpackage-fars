# invalid state number

test_that("invalid state number throws error",{
    expect_error(fars_map_state(3,2013))
})


<!-- README.md is generated from README.Rmd. Please edit that file -->

# fars

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/rsizem2/example-rpackage-fars.svg?branch=master)](https://travis-ci.com/rsizem2/example-rpackage-fars)
<!-- badges: end -->

The `fars` package consists of sample R code for analyzing vehicle crash
data. The code was provided as part of the *Building R Packages* course
on Cousera.

## The FARS datasets

Describe FARS data…

## Installation

You can install this package directly from GitHub using the `devtools`
package:

``` r
library(devtools)
install_github("rsizem2/example-rpackage-fars")
```

## Example

We can visualize the accident data for a given state if we know the
state number. For example, the state code for Kentucky is 21, so we can
generate the accidents in the year 2015 as follows:

``` r
fars_map_state(state.num = 21, year = '2015')
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

The state code for Alabama is 1, so the accidents in 2013 can be
generated with the following code:

``` r
fars_map_state(1,'2013')
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

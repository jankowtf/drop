
<!-- README.md is generated from README.Rmd. Please edit that file -->

# drop

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/valid)](https://CRAN.R-project.org/package=valid)
<!-- badges: end -->

## Installation

You can install the development version of from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("rappster/drop")
```

## What?

Drop, i.e. remove, certain values in (nested) list structures.

Experimental and scope is “scratch your own itch”.

## Why?

Because I always seem to need it at some point in various other projects
and always struggled to find/remember previous implementations that
worked.

## How?

By leveraging [rrapply](https://github.com/JorisChau/rrapply) (see [SO
post](https://stackoverflow.com/questions/63231071/recursive-remove-null-elements-of-list-of-lists))

``` r
library(drop)
```

## Drop NULL values

``` r
x <- list(
    foo = NULL,
    bar = 1,
    baz = TRUE,
    foobar = "a"
)

x %>% drop_null()
#> $bar
#> [1] 1
#> 
#> $baz
#> [1] TRUE
#> 
#> $foobar
#> [1] "a"
```

``` r
x <- list(
    list(foo = NULL, bar = 1)
)

x %>% drop_null()
#> [[1]]
#> [[1]]$bar
#> [1] 1
```

``` r
x <- list(
    foo = list(bar = NULL, baz = list(x = 1, y = NULL, z = 3)),
    baz = 2
)

x %>% drop_null()
#> $foo
#> $foo$baz
#> $foo$baz$x
#> [1] 1
#> 
#> $foo$baz$z
#> [1] 3
#> 
#> 
#> 
#> $baz
#> [1] 2
```

Empty input is simply returned

``` r
list() %>% drop_null()
#> list()
```

## Drop empty values

``` r
x <- list(
    foo = integer(),
    bar = 1,
    baz = TRUE,
    foobar = "a"
)

x %>% drop_empty()
#> $bar
#> [1] 1
#> 
#> $baz
#> [1] TRUE
#> 
#> $foobar
#> [1] "a"
```

``` r
x <- list(
    list(
        foo = character(), bar = 1)
)

x %>% drop_empty()
#> [[1]]
#> [[1]]$bar
#> [1] 1
```

``` r
x <- list(
    foo = list(bar = logical(), baz = list(x = 1, y = numeric(), z = 3)),
    baz = 2
)

x %>% drop_empty()
#> $foo
#> $foo$baz
#> $foo$baz$x
#> [1] 1
#> 
#> $foo$baz$z
#> [1] 3
#> 
#> 
#> 
#> $baz
#> [1] 2
```

Empty input is simply returned

``` r
list() %>% drop_empty()
#> list()
```

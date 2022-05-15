# Drop NULL ---------------------------------------------------------------

test_that("Drop NULL", {
    x <- list(
        foo = NULL,
        bar = 1,
        baz = TRUE,
        foobar = "a"
    )
    result <- x %>% drop_null()
    expected <- list(bar = 1, baz = TRUE, foobar = "a")
    expect_identical(result, expected)

    x <- list(
        list(
        foo = NULL,
        bar = 1
    ))
    result <- x %>% drop_null()
    expected <- list(list(bar = 1))
    expect_identical(result, expected)

    x <- list(
        foo = list(bar = NULL, baz = list(x = 1, y = NULL, z = 3)),
        baz = 2
    )
    result <- x %>% drop_null()
    expected <- list(foo = list(baz = list(x = 1, z = 3)), baz = 2)
    expect_identical(result, expected)
})

test_that("Drop NULL: empty input", {
    result <- list() %>% drop_null()
    expected <- list()
    expect_identical(result, expected)
})

# Drop empty --------------------------------------------------------------

test_that("Drop empty", {
    x <- list(
        foo = integer(),
        bar = 1,
        baz = TRUE,
        foobar = "a"
    )
    result <- x %>% drop_empty()
    expected <- list(bar = 1, baz = TRUE, foobar = "a")
    expect_identical(result, expected)

    x <- list(
        list(
            foo = character(),
            bar = 1
        ))
    result <- x %>% drop_empty()
    expected <- list(list(bar = 1))
    expect_identical(result, expected)

    x <- list(
        foo = list(bar = logical(), baz = list(x = 1, y = numeric(), z = 3)),
        baz = 2
    )
    result <- x %>% drop_empty()
    expected <- list(foo = list(baz = list(x = 1, z = 3)), baz = 2)
    expect_identical(result, expected)
})

test_that("Drop empty: empty input", {
    result <- list() %>% drop_empty()
    expected <- list()
    expect_identical(result, expected)
})

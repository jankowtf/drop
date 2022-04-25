# Drop NULL ---------------------------------------------------------------

#' Drop list elements with value `NULL`
#'
#' @param x
#'
#' @details
#' See:
#' - [drop_null.list()]
#'
#' @return ([list]) Cleaned list
#' @export
#'
#' @examples
#' x <- list(
#'     foo = list(bar = NULL, baz = list(x = 1, y = NULL, z = 3)),
#'     bar = 2,
#'     baz = NULL
#' )
#' drop_null(x)
drop_null <- function(x) {
    UseMethod("drop_null")
}

#' Drop list elements with value `NULL`
#'
#' @param x ([list]) (Nested) list object for which to drop desired values
#'
#' @return
#' @export
#'
#' @examples
#' x <- list(
#'     foo = list(bar = NULL, baz = list(x = 1, y = NULL, z = 3)),
#'     bar = 2,
#'     baz = NULL
#' )
#' drop_null(x)
drop_null.list <- function(x) {
    # x %>% rrapply::rrapply(
    #     f = identity,
    #     classes = c("numeric", "logical", "character"),
    #     # classes = "ANY",
    #     how = "prune"
    # )

    x %>% rrapply::rrapply(
        condition = Negate(is.null),
        f = function(x) x,
        how = "prune"
    )
}

# Drop empty --------------------------------------------------------------

#' Drop list elements with empty value
#'
#' @param x
#'
#' @details
#' See:
#' - [drop_empty.list()]
#'
#' @return
#' @export
#'
#' @examples
#' x <- list(
#'     foo = list(bar = integer(), baz = list(x = 1, y = character(), z = 3)),
#'     bar = 2,
#'     baz = logical()
#' )
#' drop_empty(x)
drop_empty <- function(x) {
    UseMethod("drop_empty")
}

#' Drop list elements with empty value
#'
#' @param x ([list]) (Nested) list object for which to drop desired values
#'
#' @return ([list]) Cleaned list
#' @export
#'
#' @examples
#' x <- list(
#'     foo = list(bar = integer(), baz = list(x = 1, y = character(), z = 3)),
#'     bar = 2,
#'     baz = logical()
#' )
#' drop_empty(x)
drop_empty.list <- function(x) {
    x %>%
        purrr::map(function(.x) {
            if (inherits(.x, "list")) {
                drop_empty(.x)
            } else {
                length(.x) > 0
            }
        }) %>% {
            index <- unlist(.)
            if (inherits(index, "logical")) {
                `[`(x, index)
            } else {
                .
            }
        }

    length_zero <- function(x) length(x) == 0

    x %>% rrapply::rrapply(
        condition = Negate(length_zero),
        f = function(x) x,
        how = "prune"
    )
}

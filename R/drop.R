# Drop NULL ---------------------------------------------------------------

drop_null <- function(x) {
    UseMethod("drop_null")
}

#' Drop list elements with value `NULL`
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
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

drop_empty <- function(x) {
    UseMethod("drop_empty")
}

#' Drop list elements with empty value
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
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

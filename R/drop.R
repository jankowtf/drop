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
    x %>%
        purrr::map(function(.x) {
            if (inherits(.x, "list") && is.null(names(.x))) {
                # Recall(.x)
                remove_null(.x)
            } else {
                .x %>% purrr::negate(is.null)()
            }
        }) %>% {
            index <- unlist(.)
            if (inherits(index, "logical")) {
                `[`(x, index)
            } else {
                .
            }
        }
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
}

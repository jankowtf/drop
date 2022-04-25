
# Dev dependencies --------------------------------------------------------

renv::install("devtools")
renv::install("testthat")
renv::install("roxygen2")
renv::install("roxygen2md")
renv::install("rmarkdown")
renv::install("here")

# Dev preps ---------------------------------------------------------------

# "Add the pipe"
usethis::use_pipe()

# Add package description
usethis::use_package_doc(open = FALSE)

# Use {testthat}
usethis::use_testthat()
usethis::use_package("testthat", type = "Suggests")

# Use markdown in roxygen syntax
usethis::use_roxygen_md()
roxygen2md::roxygen2md()

# Misc
usethis::use_mit_license()
usethis::use_readme_rmd(open = FALSE)
usethis::use_lifecycle()
usethis::use_lifecycle_badge("experimental")
usethis::use_news_md(open = FALSE)

usethis::use_build_ignore(
    c(
        "dev",
        "inst/examples",
        "tests"
    )
)

# Prod dependencies -------------------------------------------------------

renv::install("rrapply")
# renv::install("rappster/confx")
# usethis::use_dev_package("confx", type = "Imports", remote = "rappster/confx")

usethis::use_package("rrapply")

# Tests -------------------------------------------------------------------

usethis::use_test("drop")

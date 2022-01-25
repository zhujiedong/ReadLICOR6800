# library(usethis)
#
# usethis::use_readme_rmd()

devtools::load_all()

aci <- read_li6800("inst/extdata/racirtest1.xlsx")
names(aci)
aci$data_tag

aci <- read_li6800("inst/extdata/racirtest1.xlsx", add_tags = FALSE)
names(aci)
aci$data_tags

aci <- read_li6800_folder("inst/extdata/", add_tags = FALSE)
names(aci)
head(aci$data_tag)
tail(aci$data_tag)


aci <- read_li6800_folder("inst/extdata/", tags = paste('test', 1:2))
names(aci)
head(aci$data_tag)
tail(aci$data_tag)


devtools::check()
devtools::document()
devtools::check()
devtools::install()

if (!require(pacman)) {
  install.packages('pacman', repos = 'https://ftp.gwdg.de/pub/misc/cran/')
}

cran_pkg <- c('embed')

pkg_installed <- sapply(cran_pkg, pacman::p_exists, local = TRUE)

if (any(!pkg_installed)) {
   pacman::p_install(
    cran_pkg[ !pkg_installed],
    character.only = TRUE,
    repos = 'https://ftp.gwdg.de/pub/misc/cran/',
    Ncpus = 8
   )
}


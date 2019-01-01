if (!require(pacman)) {
  install.packages('pacman', repos = 'https://ftp.gwdg.de/pub/misc/cran/')
}

cran_pkg <- c('car', 'caret', 'corrplot', 'corrr', 'data.table', 'dplyr', 'drake', 'DT', 
    'funModeling', 'furrr', 'futile.logger', 'ggplot2', 'glue', 'keras', 'klaR', 'knitr', 'MLmetrics', 'partykit', 'purrr',
    'randomForest', 'rBayesianOptimization', 'readr', 'recipes', 'rmarkdown', 'RPushbullet', 'rsample', 'simTool',
    'skimr', 'SmartEDA', 'stringr', 'styler', 'testthat', 'tictoc', 'tidyr', 'tidytext', 'txtq', 'vtreat', 'visNetwork',
    'xgboost')

pkg_installed <- sapply(cran_pkg, pacman::p_exists, local = TRUE)

if (any(!pkg_installed)) {
   pacman::p_install(
    cran_pkg[ !pkg_installed],
    character.only = TRUE,
    repos = 'https://ftp.gwdg.de/pub/misc/cran/',
    Ncpus = parallel::detectCores()
   )
}


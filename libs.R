install.packages('pacman', repos = 'https://ftp.gwdg.de/pub/misc/cran/')

pacman::p_install(
    c('car', 'caret', 'corrplot', 'corrr', 'data.table', 'dplyr', 'drake', 'DT', 'embed',
    'funModeling', 'furrr', 'futile.logger', 'ggplot2', 'glue', 'klaR', 'knitr', 'partykit', 'purrr',
    'rBayesianOptimization', 'readr', 'recipes', 'rmarkdown', 'rsample', 'simTool',
    'skimr', 'SmartEDA', 'stringr', 'testthat', 'tictoc', 'tidyr', 'vtreat', 'xgboost'),
    repos = 'https://ftp.gwdg.de/pub/misc/cran/',
    Ncpus = 8
)

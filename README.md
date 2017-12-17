Tsumugi (紬): a data viewer of high throughput single-cell RNA-sequencing
====

This R Shiny Application is a data viewer of high throughput single-cell RNA-sequencin on your web browser.

## Install
```{r}
library(devtools)
install_github("dritoshi/tsumugi")
```

## Usage
You should copy your expression data into data directory.

Just run R and type follow commands in R:
```{r}
library(shiny)
runApp("tsumugi")
```
## Licence
[MIT](https://github.com/dritoshi/tsumugi/blob/master/LICENCE)

## Author
[dritoshi](https://github.com/dritoshi)
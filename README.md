# colorange

## Overview

colorange creates different corportate color palettes for your plots. It adds two functions `scale_color_orange()` and `scale_fill_orange()` that you can use with `ggplot2`.

Colors and palettes respect the corporate identity and style guide of Orange. See [](https://www.ateliers-orange.fr/index.php?page=marque) for more details.

## Installation

To install the package, simply run the following from an R console:

```r
# install.packages("devtools")
devtools::install_github("thoera/colorange")
```

## Usage

```r
library("ggplot2")
library("colorange")

# list all the colors
orange_colors()

# or just a subset
orange_colors(c("orange", "rose"))

# use a specific color in ggplot2
ggplot(mtcars, aes(hp, mpg)) +
  geom_point(color = orange_colors("vert"), size = 4, alpha = .8) +
  theme_minimal()

# interpolate a given palette
orange_palettes("bleus")(10)

# use a palette in ggplot2 with the scale constructor
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  geom_point(size = 4) +
  scale_color_orange(palette = "secondaire") +
  theme_minimal()

# or the fill constructor
ggplot(mpg, aes(x = fl, y = displ, fill = fl)) +
  geom_boxplot() +
  scale_fill_orange(palette = "secondaire", guide = "none") +
  theme_minimal()
```

To help you choose a palette, you can display a given palette with the `display_orange_palette()` function or view all of them at once with the `display_orange_all()` function.

```r
# display one palette
display_orange_palette("principale")

# or all the palettes
display_orange_all()
```

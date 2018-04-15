# Orange's color
list_orange_colors <- c(
  `black` = "#000000",
  `dark grey` = "#595959",
  `grey` = "#8F8F8F",
  `light grey` = "#D6D6D6",
  `orange` = "#FF7900",
  `dark blue` = "#085EBD",
  `blue` = "#4BB4E6",
  `light blue` = "#B5E8F7",
  `dark green` = "#0A6E31",
  `green` = "#50BE87",
  `light green` = "#B8EBD6",
  `dark pink` = "#FF8AD4",
  `pink` = "#FFB4E6",
  `light pink` = "#FFE8F7",
  `dark purple` = "#492191",
  `purple` = "#A885D8",
  `light purple` = "#D9C2F0",
  `dark yellow` = "#FFB400",
  `yellow` = "#FFD200",
  `light yellow` = "#FFF6B6"
)

#' Extract Orange's colors
#'
#' Extract Orange's colors as hexadecimal codes.
#'
#' @param col Character names of colors.
#' @seealso \code{\link{orange_palettes}}, \code{\link{scale_color_orange}},
#'   \code{\link{scale_fill_orange}}
#' @examples
#' orange_colors()
#' orange_colors("orange")
#' orange_colors(c("blue", "green"))
#'
#' # you can use the colors manually in plots
#' library("ggplot2")
#'
#' ggplot(mtcars, aes(hp, mpg)) +
#'   geom_point(color = orange_colors("green"), size = 4, alpha = .8) +
#'   theme_minimal()
#'
#' ggplot(mpg, aes(x = cty, y = displ, color = fl)) +
#'   geom_point(size = 4, alpha = 0.8) +
#'   scale_color_manual(
#'     values = unname(
#'       orange_colors(c("orange", "blue", "yellow", "purple", "green"))
#'     )
#'   ) +
#'   theme_minimal()
#' @export
orange_colors <- function(col = c("dark grey", "grey", "light grey",
                                  "orange",
                                  "dark blue", "blue", "light blue",
                                  "dark green", "green", "light green",
                                  "dark pink", "pink", "light pink",
                                  "dark purple", "purple", "light purple",
                                  "dark yellow", "yellow", "light yellow")) {
  if (!all(col %in% names(list_orange_colors))) {
    stop(paste("'col' should be one of",
               paste(names(list_orange_colors), collapse = ", ")))
  }
  list_orange_colors[col]
}

#' Orange Color Palettes
#'
#' A collection of color palettes that respect the corporate identity and style
#' guide of Orange. See
#' \url{https://www.ateliers-orange.fr/index.php?page=marque} for more details.
#' @export
list_orange_palettes <- list(
  "main" = orange_colors(c("blue", "green", "yellow",
                           "orange", "pink", "purple")),
  "secondary" = orange_colors(c("blue", "green", "yellow", "pink", "purple")),
  "grey" = orange_colors(c("light grey", "grey", "dark grey")),
  "blue" = orange_colors(c("light blue", "blue", "dark blue")),
  "green" = orange_colors(c("light green", "green", "dark green")),
  "pink" = orange_colors(c("light pink", "pink", "dark pink")),
  "purple" = orange_colors(c("light purple", "purple", "dark purple")),
  "yellow" = orange_colors(c("light yellow", "yellow", "dark yellow"))
)

#' Interpolate a color palette
#'
#' Interpolate a color palette.
#'
#' @param palette Character name of a palette. One of "main",
#'   "secondary", "grey", "blue", "green", "pink", "purple" or "yellow".
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param ... Additional arguments to pass to colorRampPalette().
#' @seealso \code{\link{orange_colors}}, \code{\link{scale_color_orange}},
#'   \code{\link{scale_fill_orange}}
#' @examples
#' orange_palettes("main")(2)
#' orange_palettes("secondary", reverse = TRUE)(6)
#' orange_palettes("blue")(10)
#' @export
orange_palettes <- function(palette = "main", reverse = FALSE, ...) {
  if (!palette %in% names(list_orange_palettes)) {
    stop("'palette' should be one of 'main', 'secondary', 'grey',
         'blue', 'green', 'pink', 'purple' or 'yellow'")
  }

  pal <- list_orange_palettes[[palette]]
  if (reverse) {
    pal <- rev(pal)
  }
  grDevices::colorRampPalette(pal, ...)
}

#' Color scale constructor
#'
#' This function specifies a palette, whether the palette is being applied based
#' on a discrete or numeric variable, whether to reverse the palette colors, and
#' additional arguments to pass to the relevant ggplot2 function (which differs
#' for discrete or numeric mapping).
#'
#' @param palette Character name of a palette. One of "main",
#'   "secondary", "grey", "blue", "green", "pink", "purple" or "yellow".
#' @param discrete Boolean indicating whether color aesthetic is discrete or
#'   not.
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param na_value Character name of a color for NA values.
#' @param ... Additional arguments passed to discrete_scale() or
#'   scale_color_gradientn(), used respectively when discrete is TRUE or FALSE.
#' @seealso \code{\link{orange_colors}}, \code{\link{orange_palettes}},
#'   \code{\link{scale_fill_orange}}
#' @examples
#' library("ggplot2")
#'
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
#'   geom_point(size = 4) +
#'   scale_color_orange(palette = "secondary", discrete = TRUE) +
#'   theme_minimal()
#'
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Petal.Length)) +
#'   geom_point(size = 4) +
#'   scale_color_orange(palette = "blue", discrete = FALSE) +
#'   theme_minimal()
#' @export
scale_color_orange <- function(palette = "main", discrete = TRUE,
                               reverse = FALSE, na_value = "grey50", ...) {
  pal <- orange_palettes(palette = palette, reverse = reverse)
  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("orange_", palette),
                            palette = pal, na.value = na_value, ...)
  } else {
    ggplot2::scale_color_gradientn(colors = pal(256), ...)
  }
}

#' Fill scale constructor
#'
#' This function specifies a palette, whether the palette is being applied based
#' on a discrete or numeric variable, whether to reverse the palette colors, and
#' additional arguments to pass to the relevant ggplot2 function (which differs
#' for discrete or numeric mapping).
#'
#' @param palette Character name of a palette. One of "main",
#'   "secondary", "grey", "blue", "green", "pink", "purple" or "yellow".
#' @param discrete Boolean indicating whether color aesthetic is discrete or
#'   not.
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param na_value Character name of a color for NA values.
#' @param ... Additional arguments passed to discrete_scale() or
#'   scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE.
#' @seealso \code{\link{orange_colors}}, \code{\link{orange_palettes}},
#'   \code{\link{scale_color_orange}}
#' @examples
#' library("ggplot2")
#'
#' ggplot(mpg, aes(x = fl, y = displ, fill = fl)) +
#'   geom_boxplot() +
#'   scale_fill_orange(palette = "secondary", guide = "none") +
#'   theme_minimal()
#'
#' ggplot(mpg, aes(x = manufacturer, fill = manufacturer)) +
#'   geom_bar() +
#'   scale_fill_orange(palette = "main", guide = "none") +
#'   theme_minimal() +
#'   theme(axis.text.x = element_text(angle = 45, hjust = 1))
#' @export
scale_fill_orange <- function(palette = "main", discrete = TRUE,
                              reverse = FALSE, na_value = "grey50", ...) {
  pal <- orange_palettes(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("orange_", palette),
                            palette = pal, na.value = na_value, ...)
  } else {
    ggplot2::scale_fill_gradientn(colors = pal(256), ...)
  }
}

#' Display a color palette
#'
#' Display a color palette in a graphics window.
#'
#' @param palette Character name of a palette. One of "main",
#'   "secondary", "grey", "blue", "green", "pink", "purple" or "yellow".
#' @param n Numeric indicating the number of different colors in the palette. If
#'   NULL (the default) all the colors of the palette are displayed.
#' @seealso \code{\link{orange_colors}}, \code{\link{orange_palettes}},
#'   \code{\link{display_orange_all}}
#' @examples
#' display_orange_palette("main")
#' display_orange_palette("blue", n = 10)
#' @export
display_orange_palette <- function(palette, n = NULL) {
  if (!palette %in% names(list_orange_palettes)) {
    stop("'palette' should be one of 'main', 'secondary', 'grey',
         'blue', 'green', 'pink', 'purple' or 'yellow'")
  }

  if (is.null(n)) {
    n <- length(list_orange_palettes[[palette]])
  }

  pal <- orange_palettes(palette)(n)
  graphics::image(seq_len(n), 1, as.matrix(seq_len(n)), col = pal,
                  xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n",
                  main = paste0("Palette \u201c", palette, "\u201d"))
  graphics::text(seq_len(n), 1, pal, col = "white", srt = 90)
}

#' Display all the available color palettes
#'
#' Display all the available color palettes simultanueously in a graphics
#' window.
#'
#' @seealso \code{\link{orange_colors}}, \code{\link{orange_palettes}},
#'   \code{\link{display_orange_palette}}
#' @examples
#' display_orange_all()
#' @export
display_orange_all <- function() {
  op <- graphics::par(no.readonly = TRUE)
  nrow <- ceiling(length(list_orange_palettes) / 2)
  ncol <- 2
  graphics::par(mfrow = c(nrow, ncol))
  for (i in seq_along(list_orange_palettes)) {
    pal <- names(list_orange_palettes)[[i]]
    display_orange_palette(pal)
  }
  graphics::par(op)
}

#' A simple and elegant black and white theme
#'
#' A simple and elegant black and white theme.
#'
#' @param base_family Base font family.
#' @param base_size Base font size.
#' @param title_size Title font size.
#' @param subtitle_size Subtitle font size.
#' @param caption_size Caption font size.
#' @param facet_text_size Facet font size.
#' @param axis_size Axis font size.
#' @param axis_title_position Axis title position. One of `[blmcrt]`.
#' @param plot_margin Margins of the plot.
theme_elegant <- function(base_family = "",
                          base_size = 14,
                          title_size = 18,
                          subtitle_size = 14,
                          caption_size = 11,
                          facet_text_size = 12,
                          axis_size = 12,
                          axis_title_position = "rt",
                          plot_margin = ggplot2::margin(30, 30, 30, 30)) {
  bg_color <- "#ffffff"
  bg_rect <- ggplot2::element_rect(fill = bg_color, color = bg_color)

  xj <- switch(tolower(substr(axis_title_position, 1, 1)),
               b = 0, l = 0, m = 0.5, c = 0.5, r = 1, t = 1)
  yj <- switch(tolower(substr(axis_title_position, 2, 2)),
               b = 0, l = 0, m = 0.5, c = 0.5, r = 1, t = 1)

  ggplot2::theme_minimal(base_family = base_family, base_size = base_size) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = title_size,
                                         margin = ggplot2::margin(b = 10),
                                         face = "bold"),
      plot.subtitle = ggplot2::element_text(size = subtitle_size,
                                            margin = ggplot2::margin(b = 20)),
      plot.caption = ggplot2::element_text(size = caption_size,
                                           color = "grey20",
                                           face = "italic",
                                           margin = ggplot2::margin(t = 15)),
      axis.title = ggplot2::element_text(size = axis_size),
      axis.title.x = ggplot2::element_text(hjust = xj),
      axis.title.y = ggplot2::element_text(hjust = yj),
      axis.ticks = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(margin = ggplot2::margin(t = 2)),
      axis.text.y = ggplot2::element_text(margin = ggplot2::margin(r = 2)),
      plot.background = bg_rect,
      plot.margin = plot_margin,
      panel.background = bg_rect,
      panel.border = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(size = 0.25,
                                               color = "grey80",
                                               linetype = 2),
      panel.grid.minor = ggplot2::element_blank(),
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(size = facet_text_size,
                                         hjust = 0),
      panel.spacing = grid::unit(2, "lines"),
      legend.background = bg_rect,
      legend.key.width = grid::unit(1.5, "line"),
      legend.key = ggplot2::element_blank()
    )
}

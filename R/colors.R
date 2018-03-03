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
#' orange_colors(c("bleu", "vert"))
#'
#' # you can use the colors manually in plots
#' ggplot(mtcars, aes(hp, mpg)) +
#'   geom_point(color = orange_colors("vert"), size = 4, alpha = .8) +
#'   theme_minimal()
#'
#' ggplot(mpg, aes(x = cty, y = displ, color = fl)) +
#'   geom_point(size = 4, alpha = 0.8) +
#'   scale_color_manual(
#'     values = unname(
#'       orange_colors(c("orange", "bleu", "jaune", "violet", "vert"))
#'     )
#'   ) +
#'   theme_minimal()
orange_colors <- function(col = c("gris foncé", "gris moyen", "gris clair",
                                  "orange",
                                  "bleu foncé", "bleu", "bleu clair",
                                  "vert foncé", "vert", "vert clair",
                                  "rose foncé", "rose", "rose clair",
                                  "violet foncé", "violet", "violet clair",
                                  "jaune foncé", "jaune", "jaune clair")) {
  if (!all(col %in% names(list_orange_colors))) {
    stop("'col' should be one of 'gris foncé', 'gris moyen', 'gris clair',
         'orange', 'bleu foncé', 'bleu', 'bleu clair',
         'vert foncé', 'vert', 'vert clair', 'rose foncé', 'rose',
         'rose clair', 'violet foncé', 'violet', 'violet clair',
         'jaune foncé', 'jaune', 'jaune clair'")
  }
  list_orange_colors[col]
}

# create different palettes
list_orange_palettes <- list(
  "principale" = orange_colors(c("bleu", "vert", "jaune",
                                 "orange", "rose", "violet")),
  "secondaire" = orange_colors(c("bleu", "vert", "jaune", "rose", "violet")),
  "gris" = orange_colors(c("gris clair", "gris moyen", "gris foncé")),
  "bleus" = orange_colors(c("bleu clair", "bleu", "bleu foncé")),
  "verts" = orange_colors(c("vert clair", "vert", "vert foncé")),
  "roses" = orange_colors(c("rose clair", "rose", "rose foncé")),
  "violets" = orange_colors(c("violet clair", "violet", "violet foncé")),
  "jaunes" = orange_colors(c("jaune clair", "jaune", "jaune foncé"))
)

#' Interpolate a color palette
#'
#' Interpolate a color palette.
#'
#' @param palette Character name of a palette. One of "principale",
#'   "secondaire", "gris", "bleus", "verts", "roses", "violets" or "jaunes".
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param ... Additional arguments to pass to colorRampPalette().
#' @seealso \code{\link{get_orange_cols}}, \code{\link{scale_color_orange}},
#'   \code{\link{scale_fill_orange}}
#' @examples
#' orange_palettes("principale")(2)
#' orange_palettes("secondaire", reverse = TRUE)(6)
#' orange_palettes("bleus")(10)
orange_palettes <- function(palette = "principale", reverse = FALSE, ...) {
  if (!palette %in% names(list_orange_palettes)) {
    stop("'palette' should be one of 'principale', 'secondaire', 'gris',
         'bleus', 'verts', 'roses', 'violets' or 'jaunes'")
  }

  pal <- list_orange_palettes[[palette]]
  if (reverse) {
    pal <- rev(pal)
  }
  colorRampPalette(pal, ...)
}

#' Color scale constructor
#'
#' This function specifies a palette, whether the palette is being applied based
#' on a discrete or numeric variable, whether to reverse the palette colors, and
#' additional arguments to pass to the relevant ggplot2 function (which differs
#' for discrete or numeric mapping).
#'
#' @param palette Character name of a palette. One of "principale",
#'   "secondaire", "gris", "bleus", "verts", "roses", "violets" or "jaunes".
#' @param discrete Boolean indicating whether color aesthetic is discrete or
#'   not.
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param ... Additional arguments passed to discrete_scale() or
#'   scale_color_gradientn(), used respectively when discrete is TRUE or FALSE.
#' @seealso \code{\link{get_orange_cols}}, \code{\link{orange_palettes}},
#'   \code{\link{scale_fill_orange}}
#' @examples
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
#'   geom_point(size = 4) +
#'   scale_color_orange(palette = "secondaire", discrete = TRUE) +
#'   theme_minimal()
#'
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Petal.Length)) +
#'   geom_point(size = 4) +
#'   scale_color_orange(palette = "bleus", discrete = FALSE) +
#'   theme_minimal()
scale_color_orange <- function(palette = "principale", discrete = TRUE,
                               reverse = FALSE, ...) {
  pal <- orange_palettes(palette = palette, reverse = reverse)
  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("orange_", palette),
                            palette = pal, ...)
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
#' @param palette Character name of a palette. One of "principale",
#'   "secondaire", "gris", "bleus", "verts", "roses", "violets" or "jaunes".
#' @param discrete Boolean indicating whether color aesthetic is discrete or
#'   not.
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param ... Additional arguments passed to discrete_scale() or
#'   scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE.
#' @seealso \code{\link{get_orange_cols}}, \code{\link{orange_palettes}},
#'   \code{\link{scale_color_orange}}
#' @examples
#' ggplot(mpg, aes(x = fl, y = displ, fill = fl)) +
#'   geom_boxplot() +
#'   scale_fill_orange(palette = "secondaire", guide = "none") +
#'   theme_minimal()
#'
#' ggplot(mpg, aes(x = manufacturer, fill = manufacturer)) +
#'   geom_bar() +
#'   scale_fill_orange(palette = "principale", guide = "none") +
#'   theme_minimal() +
#'   theme(axis.text.x = element_text(angle = 45, hjust = 1))
scale_fill_orange <- function(palette = "principale", discrete = TRUE,
                              reverse = FALSE, ...) {
  pal <- orange_palettes(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("orange_", palette),
                            palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colors = pal(256), ...)
  }
}

#' Display a color palette
#'
#' Display a color palette in a graphics window.
#'
#' @param palette Character name of a palette. One of "principale",
#'   "secondaire", "gris", "bleus", "verts", "roses", "violets" or "jaunes".
#' @param n Numeric indicating the number of different colors in the palette. If
#'   NULL (the default) all the colors of the palette are displayed.
#' @seealso \code{\link{get_orange_cols}}, \code{\link{orange_palettes}},
#'   \code{\link{display_orange_all}}
#' @examples
#' display_orange_palette("principale")
#' display_orange_palette("bleus", n = 10)
display_orange_palette <- function(palette, n = NULL) {
  if (!palette %in% names(list_orange_palettes)) {
    stop("'palette' should be one of 'principale', 'secondaire', 'gris',
         'bleus', 'verts', 'roses', 'violets' or 'jaunes'")
  }

  if (is.null(n)) {
    n <- length(list_orange_palettes[[palette]])
  }

  pal <- orange_palettes(palette)(n)
  image(seq_len(n), 1, as.matrix(seq_len(n)), col = pal,
        xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n",
        main = paste0("Palette “", palette, "”"))
  text(seq_len(n), 1, pal, col = "white", srt = 90)
}

#' Display all the available color palettes
#'
#' Display all the available color palettes simultanueously in a graphics
#' window.
#'
#' @seealso \code{\link{get_orange_cols}}, \code{\link{orange_palettes}},
#'   \code{\link{display_orange_palette}}
#' @examples
#' display_orange_all()
display_orange_all <- function() {
  op <- par(no.readonly = TRUE)
  nrow <- ceiling(length(list_orange_palettes) / 2)
  ncol <- 2
  par(mfrow = c(nrow, ncol))
  for (i in seq_along(list_orange_palettes)) {
    pal <- names(list_orange_palettes)[[i]]
    display_orange_palette(pal)
  }
  par(op)
}

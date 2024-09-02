library(tidyverse)
ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy))

# A basic template for GGplot:
# ggplot(data = <DATA>) +
#  <GEOM_FUNCTION>(mapping = aes(<MAPPING>))

# EDIT: the better template, after going through the whole chapter:
# ggplot(data = <DATA>) +
#  <GEOM_FUNCTION>(
#    mapping = aes(<MAPPINGS>),
#    stat = <STAT>,
#    position = <POSITION>
#  ) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>

ggplot(data = mpg)
summary(mpg)
?mpg
ggplot(data = mpg) +
  geom_point(mapping=aes(x = cyl, y = class))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, shape = class))

?mpg

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, color = cty))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, stroke = cty))

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, color = displ < 5))

## use facets for categorical variables

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cty, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg)

# different geoms
ggplot(data = mpg) +
  geom_smooth(
    mapping=aes(x = cyl, y = hwy, linetype = drv),
    show.legend = TRUE
    )

# multiplots
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy)))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# you can map different data to these different geom layers
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )

# statistical transformations: some plots create data to display
# below, it bins and counts your data
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

# interchangeable stat function for geom function
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

# stat summaries
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# positional adjustments
# stacked
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# different position args
# identity, better for 2d, like points, need transparency for bar
ggplot(
  data = diamonds,
  mapping = aes(x = cut, fill = clarity)
) +
  geom_bar(alpha = 1/5, position = "identity")
ggplot(
  data = diamonds,
  mapping = aes(x = cut, color = clarity)
) +
  geom_bar(fill = NA, position = "identity")

# fill, for bars
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "fill"
  )

# dodge
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "dodge"
  )

# jitter, to mitigate overlapping points on scatterplots
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )

# coordinate flipping, good for horizontal boxplots
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

# coord_quickmap makes spatial data appear in correct proportion, like literal maps
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

# coord_polar uses polar coordinates, for masochists who work in polar coordinates
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()

ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy)) +
  theme_igray()

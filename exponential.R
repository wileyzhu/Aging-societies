pacakages <- c("ape", "bayesplot", "brms", "broom", "dagitty", "devtools", "flextable", "GGally", "ggdag", "ggdark", "ggmcmc", "ggrepel", "ggthemes", "ghibli", "gtools", "invgamma", "loo", "patchwork", "posterior", "psych", "rcartocolor", "Rcpp", "remotes", "rstan", "santoku", "StanHeaders", "statebins", "tidybayes", "tidyverse", "viridis", "viridisLite", "wesanderson")

for (library in pacakages) {
  if (!requireNamespace(library, quietly = TRUE)) {
    install.packages(library, dependencies = TRUE)
  }
  library(library, character.only = TRUE)
}
d <- read_csv(file.choose())
glimpse(d)
d <- d %>%
  mutate(censored = ifelse(censored == "FALSE", 0, 1))

d %>%
  count(Political_Type) %>%
  slice(1:7)

d2 <- d %>%
  filter(Political_Type %in% c("Nation state", "Empire")) 
theme_set(
  theme_default() + 
    theme_tufte() +
    theme(plot.background = element_rect(fill = wes_palette("Moonrise2")[3],
                                         color = wes_palette("Moonrise2")[3]))
)
d2 %>%
  count(Political_Type) %>%
  mutate(percent = 100 * n/ sum(n)) %>%
  mutate(label = str_c(round(percent, digits = 1), "%")) %>%
  ggplot(aes(y = Political_Type)) +
  geom_col(aes(x = n, fill = Political_Type)) +
  geom_text(aes(x = n - 10, label = label), 
            color = wes_palette("Moonrise2")[3], family = "Times", hjust = 1) +
  scale_fill_manual(values = wes_palette("Moonrise2")[c(4, 1)], breaks = NULL) +
  scale_x_continuous(expression(italic(n)), breaks = c(0, count(d2, Political_Type) %>% pull(n))) +
  labs(title = "Political Type",
       y = NULL) +
  theme(axis.ticks.y = element_blank())
                       
d2 %>% 
  mutate(censored = factor(censored)) %>% 
  filter(age < 500) %>% 
  
  ggplot(aes(x = age, y = censored)) +
  # let's just mark off the 50% intervals
  stat_halfeye(.width = .5, fill = wes_palette("Moonrise2")[2], height = 4) +
  scale_y_discrete(NULL, labels = c("censored == 0", "censored == 1")) +
  coord_cartesian(ylim = c(1.5, 5.1)) +
  theme(axis.ticks.y = element_blank())  

m <-
  brm(data = d2,
      family = exponential,
      age | cens(censored) ~ 0 + Political_Type,
      prior(normal(0, 1), class = b),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 11)

print(m)

1 / exp(fixef(m))[, -2]
        
# annotation
text <-
  tibble(color = c("black", "other"),
         age = c(250, 150),
         p     = c(.55, .45),
         label = c("Nation", "Empire"),
         hjust = c(0, 1))

# wrangle
f <-
  fixef(m) %>% 
  data.frame() %>% 
  rownames_to_column() %>% 
  mutate(color = ifelse(rowname == "Political_TypeNationstate", "black", "other")) %>% 
  expand_grid(age = 0:500) %>% 
  mutate(m  = 1 - pexp(age, rate = 1 / exp(Estimate)),
         ll = 1 - pexp(age, rate = 1 / exp(Q2.5)),
         ul = 1 - pexp(age, rate = 1 / exp(Q97.5)))
  
# plot!
f %>% 
  ggplot(aes(x = age)) +
  geom_hline(yintercept = .5, linetype = 3, color = wes_palette("Moonrise2")[2]) +
  geom_ribbon(aes(ymin = ll, ymax = ul, fill = color),
              alpha = 1/2) +
  geom_line(aes(y = m, color = color)) +
  geom_text(data = text,
            aes(y = p, label = label, hjust = hjust, color = color),
            family = "Times") +
  scale_fill_manual(values = wes_palette("Moonrise2")[c(4, 1)], breaks = NULL) +
  scale_color_manual(values = wes_palette("Moonrise2")[c(4, 1)], breaks = NULL) +
  scale_y_continuous("proportion remaining", breaks = c(0, .5, 1), limits = 0:1) +
  xlab("years to collapse")        
# wrangle
post <-
  as_draws_df(m) %>% 
  pivot_longer(starts_with("b_")) %>% 
  mutate(type = str_remove(name, "b_Political_Type"),
         age  = qexp(p = .5, rate = 1 / exp(value)),
         type = factor(type, levels = rev(unique(type))))

# axis breaks
medians <-
  group_by(post, type) %>% 
  summarise(med = median(age)) %>% 
  pull(med) %>% 
  round(., digits = 1)

# plot!
post %>% 
  ggplot(aes(x = age, y = type)) +
  stat_halfeye(.width = .95, fill = wes_palette("Moonrise2")[2], height = 4) +
  scale_x_continuous("years until 50% are collapsed",
                     breaks = c(120, medians, 400), labels = c("120", medians, "400"),
                     limits = c(120, 400)) +
  ylab(NULL) +
  coord_cartesian(ylim = c(1.5, 5.1)) +
  theme(axis.ticks.y = element_blank())

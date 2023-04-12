

PieChart <- function(df, grp, value, label.loc = "outside", label.type = "abs_perc")
{

  require(ggplot2)
  require(tidyverse)
  require(ggrepel)

  df.plot <- df %>% mutate(perc = {{value}}/sum({{value}})
                  , label.perc =  paste0(round(perc*100, 1), "%")
                  , label.abs = {{value}}
                  , label.grp = {{grp}}
                  ) %>% 
  arrange(desc({{grp}})) %>%
  mutate(prop = perc / sum(perc) * 100) %>%
  mutate(ypos = cumsum(prop)- 0.5 * prop ) %>% 
  mutate(ypos2 = ypos*sum(perc)/100) 
  
  df.plot <- df.plot %>% 
    mutate(label = case_when(label.type == "abs" ~ as.character(label.abs)
                             , label.type == "perc" ~ as.character(label.perc)
                             , label.type == "abs_perc" ~ paste0(label.abs, "\n(", label.perc, ")")
                             , label.type == "perc_abs" ~ paste0(label.perc, "\n(", label.abs, ")")
                             , label.type == "grp" ~ as.character(grp)
                             , TRUE ~ as.character(label.abs)
                             )
           )
  
  p <- df.plot %>% ggplot(aes(x = "", y = perc, fill = {{grp}})) + 
    geom_bar(stat="identity", col = "white")  + 
    {
      if(label.loc == "outside")
        geom_label_repel(aes(y = ypos2, label = label, fill = {{grp}})
                         , nudge_x = 0.8
                         , show.legend = FALSE)  
      } +
    {
      if(label.loc == "inside")
        geom_text(aes(y = ypos2, label = label), color = "black")  
      } +
  theme_void() + 
  theme(legend.position="bottom") +
  scale_fill_brewer(palette="Set3") + 
  coord_polar("y", start = 0) 
  
  return(p)
}

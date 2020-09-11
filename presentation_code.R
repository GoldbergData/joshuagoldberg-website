library(DiagrammeR)
library(DiagrammeRsvg)

# Create a graph as a left-to-right path
graph <-
  create_graph() %>%
  add_path(
    n = 5,
    type = "step",
    label = c(
      "xaringan\\n .Rmd", "knitr", ".md",
      "remark.js via\\n xaringan::moon_reader", "html"),
    node_aes = node_aes(  # set node aesthetics
      shape = c("circle", "square", "circle", "rectangle", "circle"),
      width = c(0.75, 0.5, 0.5, 2, 0.5),
      color = "#3C3C3C",
      fontcolor = "black",
      fillcolor = c("#61acf0", "#f0a561", "#cbd20a", "#f0a561", "#e74a2f"),
      fontname = "Lato"
    ),
    edge_aes = edge_aes(  # set edge aesthetics
      color = "#3C3C3C"
    )
  ) %>%
  add_global_graph_attrs(attr = "layout", value = "dot", attr_type = "graph") %>%
  add_global_graph_attrs(attr = "rankdir", value = "LR", attr_type = "graph")


# View the graph in the Viewer
graph %>% render_graph()


###
# Create node data frames
###

example_graph <-
  create_graph() %>%
  add_pa_graph(
    n = 50, m = 1,
    set_seed = 23
  ) %>%
  add_gnp_graph(
    n = 50, p = 1/100,
    set_seed = 23
  ) %>%
  join_node_attrs(df = get_betweenness(.)) %>%
  join_node_attrs(df = get_degree_total(.)) %>%
  colorize_node_attrs(
    node_attr_from = total_degree,
    node_attr_to = fillcolor,
    palette = "Greens",
    alpha = 90
  ) %>%
  rescale_node_attrs(
    node_attr_from = betweenness,
    to_lower_bound = 0.5,
    to_upper_bound = 1.0,
    node_attr_to = height
  ) %>%
  select_nodes_by_id(nodes = get_articulation_points(.)) %>%
  set_node_attrs_ws(node_attr = peripheries, value = 2) %>%
  set_node_attrs_ws(node_attr = penwidth, value = 3) %>%
  clear_selection() %>%
  set_node_attr_to_display(attr = NULL)

render_graph(example_graph, layout = "nicely")

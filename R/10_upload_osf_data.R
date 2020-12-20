# Upload data to osf

library(osfr)
library(here)

osf_node_id <- "trgz7"

osf_auth()


node <- osf_retrieve_node(osf_node_id)
osf_upload(x = node, here::here("data_BA"), recure = TRUE)

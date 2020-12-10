# Download data from OSF

library(osfr)
library(here)

osf_node_id <- "trgz7"

osf_auth()


node <- osf_retrieve_node(osf_node_id)
files <- osf_ls_files(x = node)


# download files 
#, path = here("data")


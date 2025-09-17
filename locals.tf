locals {
  # normalize client and env names (lowercase)
  clients_normalized = [for c in var.clients : lower(trim(c))]
  envs_normalized    = [for e in var.environments : lower(trim(e))]

  # build a flat map keyed by "<client>-<env>" so we can for_each
  client_env_pairs = {
    for client in local.clients_normalized :
    client => {
      environments = local.envs_normalized
    }
  }

  # optional: global naming constraints
  sa_name_max_length = 24
  sa_base_max_len     = 20  # we'll append 4 hex chars
}

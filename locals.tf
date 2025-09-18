###############################################
# Locals for Derived Values
###############################################

locals {
  # Normalize input values
  clients_normalized = [for c in var.clients : lower(trim(c))]
  envs_normalized    = [for e in var.environments : lower(trim(e))]

  # Create a nested map: each client maps to a list of environments
  client_env_map = {
    for client in local.clients_normalized :
    client => {
      envs = local.envs_normalized
    }
  }

  # Flatten into a single map keyed by "<client>-<env>"
  # Example: "clienta-dev", "clientb-prod", etc.
  client_env_flat = merge([
    for c, v in local.client_env_map :
    {
      for e in v.envs :
      "${c}-${e}" => {
        client      = c
        environment = e
      }
    }
  ]...)

  # Storage account name constraints
  sa_name_max_length = 24
  sa_base_max_length = 20 # Reserve 4 chars for random suffix
}

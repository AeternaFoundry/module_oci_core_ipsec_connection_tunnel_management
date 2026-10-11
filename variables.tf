variable "core_ipsec_connection_tunnel_managements" {
  description = <<EOT
Map of core_ipsec_connection_tunnel_managements, attributes below
Required:
    - ipsec_id
    - tunnel_id
Optional:
    - display_name
    - ike_version
    - nat_translation_enabled
    - oracle_can_initiate
    - routing
    - shared_secret
    - bgp_session_info (block):
        - customer_bgp_asn (optional)
        - customer_interface_ip (optional)
        - customer_interface_ipv6 (optional)
        - oracle_interface_ip (optional)
        - oracle_interface_ipv6 (optional)
    - dpd_config (block):
        - dpd_mode (optional)
        - dpd_timeout_in_sec (optional)
    - encryption_domain_config (block):
        - cpe_traffic_selector (optional)
        - oracle_traffic_selector (optional)
    - phase_one_details (block):
        - custom_authentication_algorithm (optional)
        - custom_dh_group (optional)
        - custom_encryption_algorithm (optional)
        - is_custom_phase_one_config (optional)
        - lifetime (optional)
    - phase_two_details (block):
        - custom_authentication_algorithm (optional)
        - custom_encryption_algorithm (optional)
        - dh_group (optional)
        - is_custom_phase_two_config (optional)
        - is_pfs_enabled (optional)
        - lifetime (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    ipsec_id                = string
    tunnel_id               = string
    display_name            = optional(string)
    ike_version             = optional(string)
    nat_translation_enabled = optional(string)
    oracle_can_initiate     = optional(string)
    routing                 = optional(string)
    shared_secret           = optional(string)
    bgp_session_info = optional(object({
      customer_bgp_asn        = optional(string)
      customer_interface_ip   = optional(string)
      customer_interface_ipv6 = optional(string)
      oracle_interface_ip     = optional(string)
      oracle_interface_ipv6   = optional(string)
    }))
    dpd_config = optional(list(object({
      dpd_mode           = optional(string)
      dpd_timeout_in_sec = optional(number)
    })))
    encryption_domain_config = optional(object({
      cpe_traffic_selector    = optional(list(string))
      oracle_traffic_selector = optional(list(string))
    }))
    phase_one_details = optional(object({
      custom_authentication_algorithm = optional(string)
      custom_dh_group                 = optional(string)
      custom_encryption_algorithm     = optional(string)
      is_custom_phase_one_config      = optional(bool)
      lifetime                        = optional(number)
    }))
    phase_two_details = optional(object({
      custom_authentication_algorithm = optional(string)
      custom_encryption_algorithm     = optional(string)
      dh_group                        = optional(string)
      is_custom_phase_two_config      = optional(bool)
      is_pfs_enabled                  = optional(bool)
      lifetime                        = optional(number)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.routing == null || (contains([for v in ["BGP", "STATIC", "POLICY"] : lower(v)], lower(v.routing)))
      )
    ])
    error_message = "must be one of: \"BGP\", \"STATIC\", \"POLICY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.dpd_config == null || alltrue([for item in v.dpd_config : (item.dpd_mode == null || (contains([for v in ["INITIATE_AND_RESPOND", "RESPOND_ONLY"] : lower(v)], lower(item.dpd_mode))))])
      )
    ])
    error_message = "must be one of: \"INITIATE_AND_RESPOND\", \"RESPOND_ONLY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.ike_version == null || (contains([for v in ["V1", "V2"] : lower(v)], lower(v.ike_version)))
      )
    ])
    error_message = "must be one of: \"V1\", \"V2\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.nat_translation_enabled == null || (contains([for v in ["ENABLED", "DISABLED", "AUTO"] : lower(v)], lower(v.nat_translation_enabled)))
      )
    ])
    error_message = "must be one of: \"ENABLED\", \"DISABLED\", \"AUTO\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.oracle_can_initiate == null || (contains([for v in ["INITIATOR_OR_RESPONDER", "RESPONDER_ONLY"] : lower(v)], lower(v.oracle_can_initiate)))
      )
    ])
    error_message = "must be one of: \"INITIATOR_OR_RESPONDER\", \"RESPONDER_ONLY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.phase_one_details == null || (v.phase_one_details.custom_authentication_algorithm == null || (contains([for v in ["SHA2_384", "SHA2_256", "SHA1_96"] : lower(v)], lower(v.phase_one_details.custom_authentication_algorithm))))
      )
    ])
    error_message = "must be one of: \"SHA2_384\", \"SHA2_256\", \"SHA1_96\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.phase_one_details == null || (v.phase_one_details.custom_dh_group == null || (contains([for v in ["GROUP2", "GROUP5", "GROUP14", "GROUP19", "GROUP20", "GROUP24"] : lower(v)], lower(v.phase_one_details.custom_dh_group))))
      )
    ])
    error_message = "must be one of: \"GROUP2\", \"GROUP5\", \"GROUP14\", \"GROUP19\", \"GROUP20\", \"GROUP24\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.phase_one_details == null || (v.phase_one_details.custom_encryption_algorithm == null || (contains([for v in ["AES_256_CBC", "AES_192_CBC", "AES_128_CBC"] : lower(v)], lower(v.phase_one_details.custom_encryption_algorithm))))
      )
    ])
    error_message = "must be one of: \"AES_256_CBC\", \"AES_192_CBC\", \"AES_128_CBC\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.phase_two_details == null || (v.phase_two_details.custom_authentication_algorithm == null || (contains([for v in ["HMAC_SHA2_256_128", "HMAC_SHA1_128"] : lower(v)], lower(v.phase_two_details.custom_authentication_algorithm))))
      )
    ])
    error_message = "must be one of: \"HMAC_SHA2_256_128\", \"HMAC_SHA1_128\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.phase_two_details == null || (v.phase_two_details.custom_encryption_algorithm == null || (contains([for v in ["AES_256_GCM", "AES_192_GCM", "AES_128_GCM", "AES_256_CBC", "AES_192_CBC", "AES_128_CBC"] : lower(v)], lower(v.phase_two_details.custom_encryption_algorithm))))
      )
    ])
    error_message = "must be one of: \"AES_256_GCM\", \"AES_192_GCM\", \"AES_128_GCM\", \"AES_256_CBC\", \"AES_192_CBC\", \"AES_128_CBC\""
  }
  validation {
    condition = alltrue([
      for k, v in var.core_ipsec_connection_tunnel_managements : (
        v.phase_two_details == null || (v.phase_two_details.dh_group == null || (contains([for v in ["GROUP2", "GROUP5", "GROUP14", "GROUP19", "GROUP20", "GROUP24"] : lower(v)], lower(v.phase_two_details.dh_group))))
      )
    ])
    error_message = "must be one of: \"GROUP2\", \"GROUP5\", \"GROUP14\", \"GROUP19\", \"GROUP20\", \"GROUP24\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}


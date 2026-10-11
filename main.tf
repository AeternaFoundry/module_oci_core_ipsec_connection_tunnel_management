resource "oci_core_ipsec_connection_tunnel_management" "core_ipsec_connection_tunnel_managements" {
  for_each = var.core_ipsec_connection_tunnel_managements

  ipsec_id                = each.value.ipsec_id
  tunnel_id               = each.value.tunnel_id
  display_name            = each.value.display_name
  ike_version             = each.value.ike_version
  nat_translation_enabled = each.value.nat_translation_enabled
  oracle_can_initiate     = each.value.oracle_can_initiate
  routing                 = each.value.routing
  shared_secret           = each.value.shared_secret

  dynamic "bgp_session_info" {
    for_each = each.value.bgp_session_info != null ? [each.value.bgp_session_info] : []
    content {
      customer_bgp_asn        = bgp_session_info.value.customer_bgp_asn
      customer_interface_ip   = bgp_session_info.value.customer_interface_ip
      customer_interface_ipv6 = bgp_session_info.value.customer_interface_ipv6
      oracle_interface_ip     = bgp_session_info.value.oracle_interface_ip
      oracle_interface_ipv6   = bgp_session_info.value.oracle_interface_ipv6
    }
  }

  dynamic "dpd_config" {
    for_each = each.value.dpd_config != null ? each.value.dpd_config : []
    content {
      dpd_mode           = dpd_config.value.dpd_mode
      dpd_timeout_in_sec = dpd_config.value.dpd_timeout_in_sec
    }
  }

  dynamic "encryption_domain_config" {
    for_each = each.value.encryption_domain_config != null ? [each.value.encryption_domain_config] : []
    content {
      cpe_traffic_selector    = encryption_domain_config.value.cpe_traffic_selector
      oracle_traffic_selector = encryption_domain_config.value.oracle_traffic_selector
    }
  }

  dynamic "phase_one_details" {
    for_each = each.value.phase_one_details != null ? [each.value.phase_one_details] : []
    content {
      custom_authentication_algorithm = phase_one_details.value.custom_authentication_algorithm
      custom_dh_group                 = phase_one_details.value.custom_dh_group
      custom_encryption_algorithm     = phase_one_details.value.custom_encryption_algorithm
      is_custom_phase_one_config      = phase_one_details.value.is_custom_phase_one_config
      lifetime                        = phase_one_details.value.lifetime
    }
  }

  dynamic "phase_two_details" {
    for_each = each.value.phase_two_details != null ? [each.value.phase_two_details] : []
    content {
      custom_authentication_algorithm = phase_two_details.value.custom_authentication_algorithm
      custom_encryption_algorithm     = phase_two_details.value.custom_encryption_algorithm
      dh_group                        = phase_two_details.value.dh_group
      is_custom_phase_two_config      = phase_two_details.value.is_custom_phase_two_config
      is_pfs_enabled                  = phase_two_details.value.is_pfs_enabled
      lifetime                        = phase_two_details.value.lifetime
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}


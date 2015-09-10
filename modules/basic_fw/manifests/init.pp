#
class basic_fw(
    $ssh_port = 22
) {
    # puppet module install puppetlabs-firewall
    class { 'basic_fw::pre':
        ssh_port => $ssh_port,
    } ->
    class { 'basic_fw::post':
    }
}


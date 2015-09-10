class basic_fw::pre(
    $ssh_port = 22
) {
    Firewall {
      require => undef,
    }

    resources { 'firewall':
        purge => true,
    } ->

   # Default firewall rules
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }->
  firewall { '003 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }->
   firewall { "004 SSH port, ${ssh_port}":
       proto  => 'tcp',
       dport  => $ssh_port,
       action => 'accept',
   }
}

# profiles::nasic_setup.pp
class profiles::basic_setup {
    $ssh_port     = hiera('profiles::basic_setup::ssh_port')
    $default_user = hiera('profiles::basic_setup::default_user')
    $default_pwd  = hiera('profiles::basic_setup::default_pwd')

    file_line { 'sshd_permitrootlogin':
        path    => '/etc/ssh/sshd_config',
        match   => ".?PermitRootLogin yes",
        line    => "PermitRootLogin no",
        replace => true,
        notify  => Service['sshd'],
    } ->
    file_line { 'sshd_config':
        path    => '/etc/ssh/sshd_config',
        match   => ".?Port ",
        line    => "Port ${ssh_port}",
        replace => true,
        notify  => Service['sshd'],
    } ->
    class { 'basic_fw':
        ssh_port => $ssh_port,
    }

    service { 'sshd':
        ensure => running,
        enable => true,
    }


    # puppet module install saz-sudo
    class { '::sudo':
        purge               => false,
        config_file_replace => false,
    }

    user { $default_user:
        ensure     => 'present',
        managehome => yes,
        password   => $default_pwd,
        shell      => '/bin/bash',
    } ->
    sudo::conf { $default_user:
         content => "%${default_user} ALL=(ALL) NOPASSWD: ALL",
    }
}

node default {
  package { [ 'vim-nox', 'git' ]:
    ensure => present,
  }

  augeas { 'puppet-conf':
    context => "/files/etc/puppet/puppet.conf/main/",
    changes => [
      'set modulepath "/etc/puppet/modules:/usr/share/puppet/modules:/vagrant"'
    ]
  }

}
node default {
  package { [ 'vim-nox', 'git' ]:
    ensure => present,
  }

  augeas { 'puppet-cont':
    context => "/files/etc/puppet/puppet.conf/main/",
    changes => [
      'set modulepath "/etc/puppet/modules:/usr/share/puppet/modules:/vagrant"'
    ]
  }

}
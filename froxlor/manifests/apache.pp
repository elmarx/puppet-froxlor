class froxlor::apache inherits froxlor::config {

  file { '/var/customers':
    ensure => directory,
  }

  file { ['/var/customers/web', '/var/customers/logs']:
    ensure => directory,
    require => File['/var/customers'],
  }

  file { '/var/customers/tmp':
    ensure => directory,
    mode => 1777,
    require => File['/var/customers'],
  }

  file { '/etc/logrotate.d/froxlor':
    mode => 644,
    source => "puppet:///modules/froxlor/logrotate",
  }
}
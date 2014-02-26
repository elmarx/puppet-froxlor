class froxlor::smtp inherits froxlor::config {

  group { 'vmail':
    gid => 2000,
    require => [Package['postfix'], Package['postfix-mysql']]
  }
  ->
  user { 'vmail':
    gid => 'vmail',
    uid => 2000,
  }
  ->
  file { '/var/customers/mail':
    ensure => directory,
    owner => 'vmail',
    group => 'vmail',
    require => File['/var/customers'],
  }
  ->
  file { '/var/spool/postfix/etc/pam.d':
    ensure => directory,
  }
  ->
  file { '/var/spool/postfix/var':
    ensure => directory,
  }
  ->
  file { '/var/spool/postfix/var/run':
    ensure => directory,
  }
  ->
  file { '/var/spool/postfix/var/run/mysqld':
    ensure => directory,
  }
  ->
  file { '/etc/postfix/mysql-virtual_alias_maps.cf':
    owner => 'root',
    group => 'postfix',
    mode => 640,
    content => template('froxlor/postfix/mysql-virtual_alias_maps.cf.erb'),
  }
  ->
  file { '/etc/postfix/mysql-virtual_mailbox_domains.cf':
    owner => 'root',
    group => 'postfix',
    mode => 640,
    content => template('froxlor/postfix/mysql-virtual_mailbox_domains.cf.erb'),
  }
  ->
  file { '/etc/postfix/mysql-virtual_mailbox_maps.cf':
    owner => 'root',
    group => 'postfix',
    mode => 640,
    content => template('froxlor/postfix/mysql-virtual_mailbox_maps.cf.erb'),
  }
  ->
  file { '/etc/postfix/mysql-virtual_sender_permissions.cf':
    owner => 'root',
    group => 'postfix',
    mode => 640,
    content => template('froxlor/postfix/mysql-virtual_sender_permissions.cf.erb'),
  }
  ->
  file { '/etc/postfix/main.cf':
    owner => 'root',
    group => 'root',
    mode => 644,
    source => 'puppet:///modules/froxlor/postfix/main.cf',
  }
  ->
  file { '/etc/postfix/master.cf':
    owner => 'root',
    group => 'root',
    mode => 644,
    source => 'puppet:///modules/froxlor/postfix/master.cf',
  }
  ~>
  service { 'postfix': }

  file { '/etc/aliases':
    owner => 'root',
    group => 'root',
    content => template('froxlor/aliases.erb'),
    require => Package['postfix'],
  }
  ~>
  exec { '/usr/bin/newaliases':
    refreshonly => true,
  }
}
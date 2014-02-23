class froxlor::install inherits froxlor {

  apt::source { 'froxlor':
      location => 'http://debian.froxlor.org',
      release => 'wheezy',
      repos => 'main',
      key => 'FD88018B6F2D5390D051343FF6B4A8704F9E9BBC',
      key_server => 'pool.sks-keyservers.net',
  }

  file { '/var/cache/debconf/proftpd-basic.preseed':
    ensure => present,
    content => "proftpd-basic   shared/proftpd/inetd_or_standalone      select  from inetd",
  }

  package { 'proftpd-mod-mysql':
    ensure => present,
    responsefile => '/var/cache/debconf/proftpd-basic.preseed',
    require => [File['/var/cache/debconf/proftpd-basic.preseed'], Package['openbsd-inetd']]
  }

  class { '::mysql::server':
    root_password => $mysql_root_password,
  }

  package { ['postfix', 'openbsd-inetd', 'ssl-cert', 'dovecot-imapd', 'dovecot-pop3d', 'php5-gd', 'php5-imap', 'php5-curl', 'bind9', 'curl']: }

  package { ['froxlor', 'postfix-mysql']:
    ensure => present,
    # after https://github.com/puppetlabs/puppet/pull/2082 is merged, the following should work
    #install_options => '--no-install-recommends',
    require => [Apt::Source['froxlor'], Package['proftpd-mod-mysql'], Package['postfix'], Class['::mysql::server']]
  }

}
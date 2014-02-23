class froxlor::install inherits froxlor {

  apt::source { 'froxlor':
      location => 'http://debian.froxlor.org',
      release => 'wheezy',
      repos => 'main',
      key => 'FD88018B6F2D5390D051343FF6B4A8704F9E9BBC',
      key_server => 'pool.sks-keyservers.net',
  }

  class { '::mysql::server':
    root_password => $mysql_root_password,
  }
  ->
  package { 'postfix': }
  ->
  package { ['froxlor', 'postfix-mysql', 'ssl-cert', 'dovecot-imapd', 'dovecot-pop3d', 'php5-gd', 'php5-imap', 'php5-curl', 'proftpd-mod-mysql', 'bind9', 'curl']:
    ensure => present,
    # after https://github.com/puppetlabs/puppet/pull/2082 is merged, the following should work
    #install_options => '--no-install-recommends',
    require => Apt::Source['froxlor'],
  }

}
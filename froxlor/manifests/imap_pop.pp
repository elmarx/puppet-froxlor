class froxlor::imap_pop inherits froxlor::config {

  File {
    owner => 'root',
    group => 'root',
  }

  file { '/etc/dovecot/conf.d/10-auth.conf':
    source => 'puppet:///modules/froxlor/dovecot/conf.d/10-auth.conf',
    require => [Package['dovecot-imapd'], Package['dovecot-pop3d'], Package['dovecot-mysql']],
  }
  ->
  file { '/etc/dovecot/conf.d/10-mail.conf':
    source => 'puppet:///modules/froxlor/dovecot/conf.d/10-mail.conf',
  }
  ->
  file { '/etc/dovecot/conf.d/10-master.conf':
    source => 'puppet:///modules/froxlor/dovecot/conf.d/10-master.conf',
  }
  ->
  file { '/etc/dovecot/conf.d/15-lda.conf':
    source => 'puppet:///modules/froxlor/dovecot/conf.d/15-lda.conf',
  }
  ->
  file { '/etc/dovecot/conf.d/20-imap.conf':
    source => 'puppet:///modules/froxlor/dovecot/conf.d/20-imap.conf',
  }
  ->
  file { '/etc/dovecot/conf.d/20-pop3.conf':
    source => 'puppet:///modules/froxlor/dovecot/conf.d/20-pop3.conf',
  }
  ->
  file { '/etc/dovecot/dovecot.conf':
    source => 'puppet:///modules/froxlor/dovecot/dovecot.conf',
  }
  ->
  file { '/etc/dovecot/dovecot-sql.conf.ext':
    content => template('froxlor/dovecot/dovecot-sql.conf.ext.erb'),
    mode => 640,
    group => 'dovecot',
  }
  ~>
  service { 'dovecot': }





}
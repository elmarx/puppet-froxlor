class froxlor::ftp inherits froxlor::config {

  file { '/etc/proftpd/sql.conf':
    content => template("froxlor/proftpd/sql.conf.erb"),
    require => Package['proftpd-mod-mysql'],
  }
  ->
  file { '/etc/proftpd/modules.conf':
    source => "puppet:///modules/froxlor/proftpd/modules.conf",
    owner => 'root',
    group => 'root',
  }
  ->
  file { '/etc/proftpd/proftpd.conf':
    source => "puppet:///modules/froxlor/proftpd/proftpd.conf",
    owner => 'root',
    group => 'root',
  }
}
class froxlor::dns inherits froxlor::config {

  file_line { 'froxlor_bind':
      path => '/etc/bind/named.conf.local',
      line => 'include "/etc/bind/froxlor_bind.conf";',
      require => Package['bind9'],
  }
  ->
  file { '/etc/bind/froxlor_bind.conf':
      ensure => present,
      owner => 'root',
      group => 'bind',
      mode => 644,
  }
  ~>
  service { 'bind9': }



}
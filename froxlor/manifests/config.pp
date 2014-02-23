class froxlor::config inherits froxlor {

  exec { 'froxlor-install':
     command => "/usr/bin/curl 'http://localhost/froxlor/install/install.php' \
     -H 'Content-Type: application/x-www-form-urlencoded' \
     --data 'mysql_host=${mysql_host}&\
     mysql_database=froxlor&\
     mysql_unpriv_user=froxlor&\
     mysql_unpriv_pass=${mysql_froxlor_password}&\
     mysql_root_user=root&\
     mysql_root_pass=${mysql_root_password}&\
     admin_user=${admin_name}&\
     admin_pass1=${admin_password}&\
     admin_pass2=${admin_password}&\
     servername=${servername}&\
     serverip=${serverip}&\
     webserver=apache2&\
     httpuser=${http_user}&\
     httpgroup=${http_group}&\
     check=1&\
     language=german&\
     installstep=1&\
     '",
     creates => '/var/www/froxlor/lib/userdata.inc.php'
  }

  cron { 'froxlor':
      command => '/usr/bin/nice -n 5 /usr/bin/php5 -q /var/www/froxlor/scripts/froxlor_master_cronjob.php',
      user => 'root',
      minute => '*/5',
  }

  include "froxlor::http"
  include "froxlor::ftp"


}
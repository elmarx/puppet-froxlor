# == Class: froxlor
#
# Full description of class froxlor here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { froxlor:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class froxlor (
  $mysql_host                = $froxlor::params::mysql_host,
  $mysql_root_password       = $froxlor::params::mysql_root_password,
  $mysql_froxlor_password    = $froxlor::params::mysql_froxlor_password,
  $admin_name                = $froxlor::params::admin_name,
  $admin_password            = $froxlor::params::admin_password,
  $serverip                  = $froxlor::params::serverip,
  $servername                = $froxlor::params::servername,
  $http_user                 = $froxlor::params::http_user,
  $http_group                = $froxlor::params::http_group,
  $phpmyadmin_mysql_password = $froxlor::params::phpmyadmin_mysql_password,
  $install_at_root           = $froxlor::params::install_at_root,
  $enable_backups            = $froxlor::params::enable_backups
) inherits froxlor::params {
  include 'apt'

  anchor { 'froxlor::begin': } ->
  class { '::froxlor::install': } ->
  class { '::froxlor::config': } ->
  anchor { 'froxlor::end': }
}

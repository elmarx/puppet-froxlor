define froxlor::setting ($group, $key, $value) {
  if is_string($value) {
    $queryvalue = "'${value}'"
  }
  else {
    $queryvalue = $value
  }

  exec { "${group}_${key}":
    command => "/usr/bin/mysql -u froxlor -p${froxlor::mysql_froxlor_password} froxlor -e \
        \"update panel_settings set value = ${queryvalue} where settinggroup = '${group}' and varname = '${key}'\""
  }
}
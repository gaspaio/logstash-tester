FILTER_DATA = {
  'syslog' => [{
    # Dovecot login message via syslog
    :in => "<22>Feb  2 09:47:12 mail dovecot: pop3-login: Login: user=<somename@somedomain.fr>, method=PLAIN, rip=192.148.8.32, lip=192.148.34.126",
    :out => {
      "syslog_timestamp" => "Feb  2 09:47:12",
      "application" => "dovecot",
      "application_host" => "mail",
      "type" => "syslog",
      "message" => "pop3-login: Login: user=<somename@somedomain.fr>, method=PLAIN, rip=192.148.8.32, lip=192.148.34.126",
      "user" => "somename@somedomain.fr",
      "method" => "plain",
      "protocol" => "pop3",
      "src" => "192.148.8.32",
      "dest" => "192.148.34.126",
      "action" => "login"
    }
  }]
}

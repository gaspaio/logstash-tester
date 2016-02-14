PATTERN_DATA = {
  # Group pattern tests by application
  'Dovecot' => {
    # Be sure to capture all possible strings
    # by writing several tests for each pattern
    'DOVECOT_LOGIN' => [
    {
      :name => "Dovecot pop3 login",
      :in => "pop3-login: Login: user=<somename@somedomain.fr>, method=PLAIN, rip=192.148.8.32, lip=192.148.34.126",
      :out => {
        # Write the fields that should be present in the output
        # all other fields will be ignored in the test
        "protocol" => "pop3",
        "action" => "Login",
        "user" => "somename@somedomain.fr",
        "method" => "PLAIN",
        "remote_ip" => "192.148.8.32",
        "local_ip" => "192.148.34.126"}
    },{
      :name => "Dovecot imap login with TLS",
      :in => "imap-login: Login: user=<somename@somedomain.fr>, method=PLAIN, rip=192.148.8.32, lip=192.148.34.126, TLS",
      :out => {
        "protocol" => "imap",
        "action" => "Login",
        "user" => "somename@somedomain.fr",
        "method" => "PLAIN",
        "remote_ip" => "192.148.8.32",
        "local_ip" => "192.148.34.126"}
    },{
      :name => "Dovecot pop3 login disconnected with auth failed",
      :in => "pop3-login: Disconnected (auth failed, 1 attempts): user=<somename@somedomain.fr>, method=PLAIN, rip=192.148.8.32, lip=192.148.34.126",
      :out => {
        "protocol" => "pop3",
        "action" => "Disconnected",
        "action_info" => "auth failed, 1 attempts",
        "user" => "somename@somedomain.fr",
        "method" => "PLAIN",
        "remote_ip" => "192.148.8.32",
        "local_ip" => "192.148.34.126"}
    }]
  }
}


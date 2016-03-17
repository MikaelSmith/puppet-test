class test {

  include ::ntp

  package {'foo':
    ensure => '1.0.0-1'
  }

}

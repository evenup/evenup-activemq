# == Class: activemq::service
#
# This class maintaines the ActiveMQ service.  It should not be directly invoked.
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class activemq::service (
  $ensure,
) {

  $real_running = $ensure ? {
    'absent'  => 'stopped',
    default   => 'running',
  }

  $real_enable = $ensure ? {
    'absent'  => false,
    default   => true,
  }

  service {
    'activemq':
      ensure  => $real_running,
      enable  => $real_enable,
  }

}

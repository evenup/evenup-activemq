# == Class: activemq::install
#
# This class maintaines the ActiveMQ package.  It should not be directly invoked.
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class activemq::install (
  $ensure,
) {

  package {
    'activemq':
      ensure  => $ensure;
  }

}

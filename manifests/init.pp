# == Class: activemq
#
# This class installs and configures ActiveMQ
#
# === Parameters
#
# [*ensure*]
#   String.  Controls whether ActiveMQ should be installed or absent.
#   Valid options are: present, absent, latest, installed, or a specific version
#
# [*maxmemory*]
#   Integer.  Maximum amount of memory given to ActiveMQ
#
# [*webconsle*]
#   Boolean.  Whether or not the webconsole should be installed
#
# [*admin_user*]
#   String.  Username created as the admin user.
#
# [*admin_pass*]
#   String.  Password given to admin_user.
#
# [*stats_user*]
#   String.  Username created as the stats user.
#
# [*stats_pass*]
#   String.  Password given to stats_user.
#
# [*openwire_port*]
#   Integer.  What port the openwire connecttor should listen on
#
# [*stomp_port*]
#   Integer.  What port the stomp connector should listen on
#
# === Examples
#
# * Installation:
#     class { 'activemq': }
#
# * Removal/decommissioning:
#     class { 'activemq':
#       ensure => 'absent',
#     }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class activemq (
  $ensure         = 'latest',
  $maxmemory      = 512,
  $webconsole     = true,
  $admin_user     = 'admin',
  $admin_pass     = 'admin',
  $stats_user     = 'stats',
  $stats_pass     = 'stats',
  $openwire_port  = 61616,
  $stomp_port     = 61613,
) {

  anchor{ 'activemq::begin': }
  anchor{ 'activemq::end': }

  Anchor['activemq::begin'] ->
  Class['activemq::install'] ->
  Class['activemq::config'] ~>
  Class['activemq::service'] ->
  Anchor['activemq::end']

  class { 'activemq::install':
    ensure  => $ensure,
  }

  class { 'activemq::config':
    ensure        => $ensure,
    maxmemory     => $maxmemory,
    admin_user    => $admin_user,
    admin_pass    => $admin_pass,
    stats_user    => $stats_user,
    stats_pass    => $stats_pass,
    webconsole    => $webconsole,
    loglevel      => $loglevel,
    openwire_port => $openwire_port,
    stomp_port    => $stomp_port,
  }

  class { 'activemq::service':
    ensure  => $enable,
  }

}

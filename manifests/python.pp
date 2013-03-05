# == Class: activemq::python
#
# This class is able to either install or remove the activemq package
#
# === Parameters
#
# [*ensure*]
#   String.  Controls if the script should be present or absent.  If set
#   to absent:
#     * The python activemq package is removed
#   Defaults to present
#
# === Examples
#
# * Installation:
#     class { 'activemq::python': }
#
# * Removal/decommissioning:
#     class { 'activemq::python':
#       ensure => 'absent',
#     }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2012 EvenUp.
#
class activemq::python ($ensure = 'present') {
  $real_ensure = $ensure

  # Required since python-txAMQP doesn't depend on it as it should
  package { 'python-twisted-core':
    ensure  => installed
  }

  package { 'python-txAMQP':
    ensure => $real_ensure;
  }
}

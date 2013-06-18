# == Class: activemq::config
#
# This class configures ActiveMQ.  It should not be directly invoked.
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class activemq::config (
  $ensure,
  $maxmemory,
  $webconsole,
  $admin_user,
  $admin_pass,
  $stats_user,
  $stats_pass,
  $openwire_port,
  $stomp_port,
) {

  $real_ensure = $ensure ? {
    'absent'  => 'absent',
    default   => 'file'
  }

  file { '/etc/activemq/activemq-wrapper.conf':
    ensure  => $real_ensure,
    owner   => activemq,
    group   => activemq,
    mode    => '0440',
    content => template('activemq/activemq-wrapper.conf.erb'),
  }

  file {  '/etc/activemq/credentials.properties':
    ensure  => $real_ensure,
    owner   => activemq,
    group   => activemq,
    mode    => '0440',
    content => template('activemq/credentials.properties.erb'),
  }

  file { '/etc/activemq/jetty-realm.properties':
    ensure  => $real_ensure,
    owner   => activemq,
    group   => activemq,
    mode    => '0440',
    content => template('activemq/jetty-realm.properties.erb'),
  }

  file { '/etc/activemq/jetty.xml':
    ensure  => $real_ensure,
    owner   => activemq,
    group   => activemq,
    mode    => '0440',
    source  => 'puppet:///modules/activemq/jetty.xml',
  }

  file { '/etc/activemq/log4j.properties':
    ensure  => $real_ensure,
    owner   => activemq,
    group   => activemq,
    mode    => '0440',
    source  => 'puppet:///modules/activemq/log4j.properties',
  }

  file { '/usr/share/activemq/webapps/admin/WEB-INF/webconsole-embedded.xml':
    ensure  => $real_ensure,
    owner   => activemq,
    group   => activemq,
    mode    => '0440',
    source  => 'puppet:///modules/activemq/webconsole-embedded.xml',
  }

  concat {
    '/etc/activemq/activemq.xml':
      owner  => activemq,
      group  => activemq,
      mode   => '0440',
  }

  concat::fragment {
    'activemq.xml.header':
      content => template('activemq/activemq-header.xml.erb'),
      target  => '/etc/activemq/activemq.xml',
      order   => 01,
  }

  concat::fragment {
    'activemq.xml.mid':
      content => template('activemq/activemq-mid.xml.erb'),
      target  => '/etc/activemq/activemq.xml',
      order   => 45,
  }

  concat::fragment {
    'activemq.xml.footer':
      content => template('activemq/activemq-footer.xml.erb'),
      target  => '/etc/activemq/activemq.xml',
      order   => 99,
  }

  # Set up a few basic users
  activemq::authentication { $admin_user:
    password  => $admin_pass,
    groups    => 'admins,everyone',
  }

  activemq::authentication { $stats_user:
    password  => $stats_pass,
    groups    => 'stats',
  }

  # Authorization for stats and admin
  activemq::authorization { 'admin-topic':
    type        => 'topic',
    destination => '',
    allperms    => 'admins',
  }

  activemq::authorization { 'admin-queue':
    type        => 'queue',
    destination => '',
    allperms    => 'admins',
  }

  activemq::authorization { 'stats-topic':
    type        => 'topic',
    destination => 'stats.statsresults.',
    allperms    => 'stats',
  }

  activemq::authorization { 'stats-queue':
    type        => 'queue',
    destination => 'ActiveMQ.Statistics.Destination.',
    allperms    => 'stats',
  }

}

# == Define: activemq::authorization
#
# This define is used to create authorization entries
#
# === Parameters
#
# [*type*]
#   String.  Authorization type.
#   Valid values: queue/topic
#
# [*destination*]
#   String.  Queue authorization is granted on
#
# [*read*]
#   String.  User to grant read access to
#
# [*write*]
#   String.  User to grant write access to
#
# [*admin*]
#   String.  User to grant admin access to
#
# [*allperms*]
#   String.  User to grant read, write, and admin access to
#
#
# === Examples
#
# activemq::authorization { 'foo-myqueue-topic':
#   type        => 'topic',
#   destination => 'myqueue.',
#   allperms    => 'myuser',
# }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
define activemq::authorization(
  $type,
  $destination,
  $read            = undef,
  $write           = undef,
  $admin           = undef,
  $allperms        = undef,
) {

  if !($read and $write and $admin) and !$allperms {
    crit('Either all of [read, write, admin] or [allperms] must be specified')
  }

  if $type != 'queue' or $type != 'topic' {
    crit('Topic must be "queue" or "topic"')
  }

  if $allperms {
    $read_string  = " read=\"${allperms}\""
    $write_string = " write=\"${allperms}\""
    $admin_string = " admin=\"${allperms}\""
  }
  else {
    if $read {
      $read_string  = " read=\"${read}\""
    }
    if $write {
      $write_string = " write=\"${write}\""
    }
    if $admin {
      $admin_string = " admin=\"${admin}\""
    }
  }

  concat::fragment { "${name}-authorization":
    content => "                  <authorizationEntry ${type}=\"${destination}>\"${read_string}${write_string}${admin_string} />\n",
    order   => '50',
    target  => '/etc/activemq/activemq.xml',
  }
}

# == Define: activemq::authentication
#
# This define is used to create users
#
# === Parameters
#
# [*username*]
#   String.  Username of the user
#
# [*password*]
#   String.  Password of the user
#
# [*groups*]
#   String.  Comma seperated list of groups user is a member of
#
# === Examples
#
# activemq::authentication { 'foouser':
#   password  => 'strongpass',
#   groups    => 'somegroup,everyone',
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
define activemq::authentication(
  $username = $name,
  $password,
  $groups,
) {

  concat::fragment { "${name}-authentication":
    content => "              <authenticationUser username=\"${username}\" password=\"${password}\" groups=\"${groups}\"/>\n",
    order   => '40',
    target  => '/etc/activemq/activemq.xml',
  }
}

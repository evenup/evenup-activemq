#ActiveMQ module for puppet

This module that installs and configures ActiveMQ.


##Installation
This module depends on [ripienaar/concat](http://forge.puppetlabs.com/ripienaar/concat)

This module can be installed via the puppet module tool (puppet version >= 2.7.14).

  puppet module install evenup/activemq

##Usage
Parameters:

* ensure: absent, latest, present, or version number of ActiveMQ package
* maxmemory: Maximum amount of memory ActiveMQ may use
* webconsole: Whether or not to enable the webconsle.  true/false
* admin_user: Admin username
* admin_pass: Admin password
* stats_user: Stats username
* stats_pass: Stats password
* openwire_port: What port should the openwire connector listen on
* stomp_port: What port should the stomp connector listen on

Example:
  class { 'activemq':
    ensure      => 'latest',
    webconsle   => false,
    admin_pass  => 'secretpass',
    stats_pass  => 'secretpass',
  }


## License
Released under the Apache 2.0 licence

## Contribute
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
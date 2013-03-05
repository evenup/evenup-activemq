require 'spec_helper'

describe 'activemq', :type => :class do
  
  let (:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should create_class('activemq') }
  it { should contain_class('activemq::install') }
  it { should contain_class('activemq::config') }
  it { should contain_class('activemq::service') }

end

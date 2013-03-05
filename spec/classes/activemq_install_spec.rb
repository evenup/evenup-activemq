require 'spec_helper'

describe 'activemq::install', :type => :class do
  let(:params) { { :ensure => 'latest' } }

  it { should contain_package('activemq').with_ensure('latest') }
end

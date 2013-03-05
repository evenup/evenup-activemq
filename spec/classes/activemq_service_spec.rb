require 'spec_helper'

describe 'activemq::service', :type => :class do

  context 'default (enabled)' do
    let(:params) { { :ensure => 'latest' } }

    it { should contain_service('activemq').with(
      'ensure'  => 'running',
      'enable'  => true
    ) }
  end

  context 'default (absent)' do
    let(:params) { { :ensure => 'absent' } }

    it { should contain_service('activemq').with(
      'ensure'  => 'stopped',
      'enable'  => false
    ) }
  end

end

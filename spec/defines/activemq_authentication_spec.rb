require 'spec_helper'

describe 'activemq::authentication', :type => :define do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }
  let(:title) { 'testuser' }

  context 'username' do
    let(:params) { { :username => 'username', :password => 'mypass', :groups => 'group' } }

    it { should contain_concat__fragment('testuser-authentication').with_content(/username="username"/) }
  end

  context 'password/groups' do
    let(:params) { { :password => 'mypass', :groups => 'group' } }

    it { should contain_concat__fragment('testuser-authentication').with_content(/username="testuser"/) }
    it { should contain_concat__fragment('testuser-authentication').with_content(/password="mypass"/) }
    it { should contain_concat__fragment('testuser-authentication').with_content(/groups="group"/) }
  end

end

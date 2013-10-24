require 'spec_helper'

describe 'activemq::authorization', :type => :define do
  let(:title) { 'auth' }
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  context 'queue, read' do
    let(:params) { { :type => 'queue', :destination => 'queuename', :read => 'testuser' } }
    it { should contain_concat__fragment('auth-authorization').with_content(/<authorizationEntry queue="queuename>" read="testuser" \/>/) }
  end

  context 'topic, write and admin' do
    let(:params) { { :type => 'topic', :destination => 'queuename', :write => 'testuser', :admin => 'testuser' } }
    it { should contain_concat__fragment('auth-authorization').with_content(/<authorizationEntry topic="queuename>" write="testuser" admin="testuser" \/>/) }
  end

  context 'allperms' do
    let(:params) { { :type => 'queue', :destination => 'queuename', :allperms => 'testuser' } }
    it { should contain_concat__fragment('auth-authorization').with_content(/<authorizationEntry queue="queuename>" read="testuser" write="testuser" admin="testuser" \/>/) }
  end
end

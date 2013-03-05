require 'spec_helper'

describe 'activemq::config', :type => :class do
  let (:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }
  let(:params) { {
    :ensure         => 'latest',
    :maxmemory      => '256',
    :webconsole     => false,
    :admin_user     => 'auser',
    :admin_pass     => 'apass',
    :stats_user     => 'suser',
    :stats_pass     => 'spass',
    :openwire_port  => '1234',
    :stomp_port     => '2345',
  } }

  context 'activemq-wrapper.conf' do
    it { should contain_file('/etc/activemq/activemq-wrapper.conf').with_content(/wrapper\.java\.maxmemory=256/) }
  end

  context 'credentials.properties' do
    it { should contain_file('/etc/activemq/credentials.properties').with_content(/activemq.username=auser/) }
    it { should contain_file('/etc/activemq/credentials.properties').with_content(/activemq.password=apass/) }
  end

  context 'jetty-realm.properites' do
    it { should contain_file('/etc/activemq/jetty-realm.properties').with_content(/admin:\sauser,\sapass/) }
  end

  context 'jetty.xml' do
    it { should contain_file('/etc/activemq/jetty.xml') }
  end

  context 'log4j.properties' do
    it { should contain_file('/etc/activemq/log4j.properties') }
  end

  context 'webconsole-embedded.xml' do
    it { should contain_file('/usr/share/activemq/webapps/admin/WEB-INF/webconsole-embedded.xml') }
  end

  context 'activemq.xml' do
    it { should contain_concat('/etc/activemq/activemq.xml') }
    it { should contain_concat__fragment('activemq.xml.header').with_order('01') }
    it { should contain_concat__fragment('activemq.xml.mid').with_order(45) }
    it { should contain_concat__fragment('activemq.xml.footer').with_order(99) }

    it { should contain_activemq__authentication('auser').with_password('apass').with_groups('admins,everyone') }
    it { should contain_activemq__authentication('suser').with_password('spass').with_groups('stats') }
    it { should contain_activemq__authorization('admin-topic') }
    it { should contain_activemq__authorization('admin-queue') }
    it { should contain_activemq__authorization('stats-topic') }
    it { should contain_activemq__authorization('stats-queue') }
  end

end

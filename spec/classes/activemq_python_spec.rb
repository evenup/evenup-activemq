require 'spec_helper'
 
describe 'activemq::python', :type => :class do
 
   let :default_params do
    {
      'ensure'  => 'present'
    }
  end
 
  describe "activemq::python class with default parameters" do
#    let(:params) { :default_params }
  
    it { should create_class('activemq::python') }
    it { should create_package('python-twisted-core') }
    it { should create_package('python-txAMQP') }  
  end
  
  describe "activemq::python class with ensure => absent" do
    let(:params) { { 'ensure' => 'absent' } }
    
    it { should create_class('activemq::python') }
    it { should create_package('python-txAMQP').with_ensure('absent') }
  end
  
end

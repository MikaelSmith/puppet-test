require 'spec_helper'
describe 'test', :type => :class  do
  context "Linux defaults" do
    let :facts do
      {
        :puppetversion => Puppet.version,
        :kernel => 'Linux',
      }
    end
    context "on CentOS" do
      let :facts do
        super().merge({
          :osfamily => 'RedHat',
          :operatingsystem => 'CentOS',
          :operatingsystemrelease => '6.6',
          :operatingsystemmajrelease => '6',
        })
      end

      %w{ntp}.each do |puppet_class|
        it { is_expected.to contain_class(puppet_class) }
      end
      it { is_expected.to compile.with_all_deps }

      context "version 7" do
        let :facts do
          super().merge({
            :operatingsystemrelease => '7.1.1503',
            :operatingsystemmajrelease => '7',
          })
        end
      end

      context "version 6" do
        let :facts do
          super().merge({
            :operatingsystemrelease => '6.6',
            :operatingsystemmajrelease => '6',
          })
        end
      end
    end
  end
end
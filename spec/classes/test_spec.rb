require 'spec_helper'

provider_class = Puppet::Type.type(:package).provider(:rpm)

describe 'test', :type => :class  do
  context "Linux defaults" do
      let :facts do
        {
          :puppetversion => Puppet.version,
          :kernel => 'Linux',
          :kernelmajversion => '3.10',
          :kernelrelease => '3.10.0-327.10.1.el7.x86_64',
          :kernelversion => '3.10.0',
          :os => {
            :architecture => "x86_64",
            :family => "RedHat",
            :hardware => "x86_64",
            :name => "CentOS",
            :release => {
              :full => "7.2.1511",
              :major => "7",
              :minor => "2"
            }
          },
          :lsbdistcodename => 'Final',
          :lsbdistdescription => 'CentOS release 6.5 (Final)',
          :lsbdistid => 'CentOS',
          :lsbdistrelease => '6.5',
          :lsbmajdistrelease => '6',
          :lsbminordistrelease => '5',
        }
      end
    context "on CentOS" do
      let(:resource) do
        Puppet::Type.type(:package).new(
          :provider => 'rpm'
        )
      end
      let :provider do
        provider = provider_class.new
        provider.resource = resource
        provider
      end
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

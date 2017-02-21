if os[:family] == 'debian'
  describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
    its(:content) { should match(/serveragent main/) }
    its(:content) { should match(/cloudmonitoring main/) }
  end

  %w(unattended-upgrades debconf).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  describe command('debconf-get-selections | grep true') do
    its(:stdout) { should match(%r{unattended-upgrades\sunattended-upgrades/enable_auto_updates\sboolean\strue}) }
  end
end
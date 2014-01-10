require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'sudo' }

  it { should contain_package('sudo').with_ensure('present') }

  it do
    should contain_file('/etc/sudoers.d').with({
      'ensure'  => 'directory',
      'mode'    => '0550',
      'purge'   => 'true',
      'recurse' => 'true',
    })
  end

  it do
    should contain_file('/etc/sudoers').with({
      'owner'  => 'root',
      'require' => '[File[/etc/sudoers.d]{:path=>"/etc/sudoers.d"}, Package[sudo]{:name=>"sudo"}]',
      'group'   => 'root',
      'mode'    => '0440',
      'ensure'  => 'present',
    })
  end

  it { should contain_class('sudo::user_alias') } 
  it { should contain_class('sudo::cmnd_alias') } 
  it { should contain_class('sudo::defaults') } 
  it { should contain_class('sudo::runas_alias') } 
  it { should contain_class('sudo::host_alias') } 
  it { should contain_class('sudo::entry') } 

end



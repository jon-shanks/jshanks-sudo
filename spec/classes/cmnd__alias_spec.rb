require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'command_aliases' }

  file = 'command_aliases'
  priority = '30'

  it do
    should contain_file("/etc/sudoers.d/#{priority}-#{file}").with({
      'mode'    => '0440',
      'require' => 'Class[Sudo]',
    })
  end

  context 'with command_aliases hash defined' do
    let(:params) { {:c_aliases => {"DDM_SOLARIS_LINUX_CMD"=>{"comment"=>"DDMa/DDMi", "commands"=>["/bin/cat", "/usr/bin/hostid", "/bin/ls", "/bin/netstat", "/bin/rpm -q [-a-zA-Z0-9]*"]}} } }

      it 'should generate valid content for command_aliases file' do
        content = catalogue.resource('file', "/etc/sudoers.d/#{priority}-#{file}").send(:parameters)[:content]
        content.should_not be_empty
        content.should match('Cmnd_Alias')
      end
  end

end


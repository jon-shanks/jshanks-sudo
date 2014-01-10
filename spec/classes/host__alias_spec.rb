require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'host_aliases' }

  file = 'host_aliases'
  priority = '50'

  it do
    should contain_file("/etc/sudoers.d/#{priority}-#{file}").with({
      'mode'    => '0440',
      'require' => 'Class[Sudo]',
    })
  end

  context 'with host_aliases hash defined' do
    let(:params) { {:h_aliases => {"PUPPET_SERVERS"=>{"comment"=>"list of puppet server hosts", "hosts"=>["pb2svpoc01v.europe.nyx.com", "pb2svpoc02v.europe.nyx.com"]}, "PUPPET_SERVERS2"=>{"comment"=>"list of puppet server hosts 2", "hosts"=>["pb2svpoc03v.europe.nyx.com", "pb2svpoc04v.europe.nyx.com"]}} } }

      it 'should generate valid content for host_aliases file' do
        content = catalogue.resource('file', "/etc/sudoers.d/#{priority}-#{file}").send(:parameters)[:content]
        content.should_not be_empty
        content.should match('Host_Alias')
      end
  end

end


require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'defaults' }

  file = 'defaults'
  priority = '10'

  it do
    should contain_file("/etc/sudoers.d/#{priority}-#{file}").with({
      'mode'    => '0440',
      'require' => 'Class[Sudo]',
    })
  end

  context 'with defaults hash defined' do
    let(:params) { {:default => {"requiretty"=>{"comment"=>"Disable requiretty", "command"=>"!requiretty"} }} }

      it 'should generate valid content for defaults_aliases file' do
        content = catalogue.resource('file', "/etc/sudoers.d/#{priority}-#{file}").send(:parameters)[:content]
        content.should_not be_empty
        content.should match('Defaults')
      end
  end

end


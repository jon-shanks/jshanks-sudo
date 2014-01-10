require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'entry' }

  file = 'sudo_entries'
  priority = '90'

  it do
    should contain_file("/etc/sudoers.d/#{priority}-#{file}").with({
      'mode'    => '0440',
      'require' => 'Class[Sudo]',
    })
  end

  context 'with entry list hash defined' do
    let(:params) { {:entry =>{"root"=>{"comment"=>"Root user to do everything", "users"=>["ALL"], "hosts"=>["ALL"], "commands"=>["ALL"]}}} }

      it 'should generate valid content for entry_list file' do
        content = catalogue.resource('file', "/etc/sudoers.d/#{priority}-#{file}").send(:parameters)[:content]
        content.should_not be_empty
        content.should match('root')
      end
  end

end


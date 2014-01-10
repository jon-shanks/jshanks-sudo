require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'user_aliases' }

  file = 'user_aliases'
  priority = '20'

  it do
    should contain_file("/etc/sudoers.d/#{priority}-#{file}").with({
      'mode'    => '0440',
      'require' => 'Class[Sudo]',
    })
  end

  context 'with user_aliases hash defined' do
    let(:params) { {:u_aliases => {"U_BTEA"=>{"comment"=>"Support app team", "users"=>["%nyxeu-app", "%nyxeu-operation", "%opslevel2"]}, "MONITOR_USRS"=>{"comment"=>"Define users that monitor the system (for now patrol but maybe openview)", "users"=>["patrol"]}} } }

      it 'should generate valid content for user_aliases file' do
        content = catalogue.resource('file', "/etc/sudoers.d/#{priority}-#{file}").send(:parameters)[:content]
        content.should_not be_empty
        content.should match('User_Alias')
      end
  end

end


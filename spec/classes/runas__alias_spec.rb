require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'runas_aliases' }

  file = 'runas_aliases'
  priority = '40'

  it do
    should contain_file("/etc/sudoers.d/#{priority}-#{file}").with({
      'mode'    => '0440',
      'require' => 'Class[Sudo]',
    })
  end

  context 'with runas_aliases hash defined' do
    let(:params) { {:r_aliases => {"R_BTEA"=>{"comment"=>"Declaration: destination accounts (Runas_Alias)", "users"=>["popmdspy"]}} } }

      it 'should generate valid content for runas_aliases file' do
        content = catalogue.resource('file', "/etc/sudoers.d/#{priority}-#{file}").send(:parameters)[:content]
        content.should_not be_empty
        content.should match('Runas_Alias')
      end
  end

end


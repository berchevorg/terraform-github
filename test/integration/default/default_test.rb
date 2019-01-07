control 'check_website' do

  describe http('https://github.com/berchevorg/tf-github-repo') do
    its('status') { should cmp 200 }
    its('body') { should match 'This is a github repo created with terraform' }
  end

end

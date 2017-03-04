# Install sshpass rpm
bash 'install sshpass rpm' do
  user 'root'

  code <<-EOH
  rpm -Uvh /vagrant/sshpass-1.05-1.el7.rf.x86_64.rpm
  EOH

end

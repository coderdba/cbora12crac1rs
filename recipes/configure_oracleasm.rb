#
#
#   Configures oracleasm (not the asm disks)
#
#   TBD - Loop through array of node than separately calling them out
#   TBD - Keep root password in a data-bag or in an attribute

dbUser=node[:dbUser]
groupToUse=node[:oinstallGroup]

bash 'configuring oracleasm driver on node1' do
  user "root"
  code <<-EOH
    # NOT oinstall
    #oracleasm configure -e -u grid -g oinstall -s y  > /tmp/oracleasm.configure.node1.out

    # NOT asmdba
    #oracleasm configure -e -u grid -g asmadmin -s y  > /tmp/oracleasm.configure.node1.out

    oracleasm configure -e -u grid -g asmadmin -s y  > /tmp/oracleasm.configure.node1.out
    oracleasm init >> /tmp/oracleasm.configure.node1.out
  EOH
end

bash 'configuring oracleasm driver on node2' do
  user "root"
  code <<-EOH
    #sshpass -p "#{node[:rootPassword]}" ssh -o StrictHostKeyChecking=no "root"@"#{node[:hostnameNode2]}" oracleasm configure -e -u grid -g oinstall -s y  > /tmp/oracleasm.configure.node2.out
    sshpass -p "#{node[:rootPassword]}" ssh -o StrictHostKeyChecking=no "root"@"#{node[:hostnameNode2]}" oracleasm configure -e -u grid -g asmdba -s y  > /tmp/oracleasm.configure.node2.out

    sshpass -p "#{node[:rootPassword]}" ssh -o StrictHostKeyChecking=no "root"@"#{node[:hostnameNode2]}" oracleasm init >> /tmp/oracleasm.configure.node2.out

  EOH
end

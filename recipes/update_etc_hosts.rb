#
# Update /etc/hosts with cluster node details
#
#

hostsFile=node[:hostsFile]

if File.exist?("#{hostsFile}.orig")

  execute 'backup current #{hostsFile}' do
    user "root"
    command "  mv #{hostsFile} #{hostsFile}.bak"
  end

else

  execute 'backup current #{hostsFile}' do
    user "root"
    command "  mv #{hostsFile} #{hostsFile}.orig"
  end

end

template "#{hostsFile}" do
  source 'etc_hosts.erb'
   owner 'root'
   group 'root'
    mode '0755'
    variables({
      :hostnameNode1   => node[:hostnameNode1],
      :hostnameNode2   => node[:hostnameNode2],
      :publicIpNode1   => node[:publicIpNode1],
      :publicIpNode2   => node[:publicIpNode2],
      :virtualIpNode1  => node[:virtualIpNode1],
      :virtualIpNode2  => node[:virtualIpNode2],
      :privateIpNode1  => node[:privateIpNode1],
      :privateIpNode2  => node[:privateIpNode2],
      :clusterName     => node[:clusterName],
      :scanIp1         => node[:scanIp1],
      :scanIp2         => node[:scanIp2],
      :scanIp3         => node[:scanIp3]
  })
end

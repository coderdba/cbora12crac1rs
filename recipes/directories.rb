#
#   Creates necessary directories for RAC install
#
# TBD - create a erb file to generate a shell script, create that shell in node1,
#       execute it in node1 and  with ssh in node2 in two steps here

directory node[:oraBase][:rootDir] do
  action :create
end

directory node[:oraBase][:appDir] do
  action :create
end

directory node[:oraBase][:dirName] do
  owner node[:oraBase][:dirOwner]
  group node[:oraBase][:dirGroup]
  mode  node[:oraBase][:dirPerm]
  action :create
end

directory node[:oraInventory][:dirName] do
  owner node[:oraInventory][:dirOwner]
  group node[:oraInventory][:dirGroup]
  mode  node[:oraInventory][:dirPerm]
  action :create
end

directory node[:gridHome][:dirName] do
  owner node[:gridHome][:dirOwner]
  group node[:gridHome][:dirGroup]
  mode  node[:gridHome][:dirPerm]
  action :create
end

directory node[:gridBase][:dirName] do
  owner node[:gridBase][:dirOwner]
  group node[:gridBase][:dirGroup]
  mode  node[:gridBase][:dirPerm]
  action :create
end

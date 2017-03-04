#
#
#   prepare_asm_disks.rb
#
#   Formats disks using 'sfdisk'
#   Creates ASM disks using oracleasm
#
# TBD - add checks to see if these disks are already formatted, and do only if not
# TBD - make an array of disks, their sizes and sfdisk tempalte erb files in attributes file, and loop through

# Create the template file to use for sfdisk command
template node[:sfdisk2gb_format_file] do
  source node[:sfdisk2gb_format_template]
end

# Format 2gb disks
formatFile = node[:sfdisk2gb_format_file]

diskDev=node[:diskDev1]
execute 'sfdisk 1' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

diskDev=node[:diskDev2]
execute 'sfdisk 2' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

diskDev=node[:diskDev3]
execute 'sfdisk 3' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

diskDev=node[:diskDev4]
execute 'sfdisk 4' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

diskDev=node[:diskDev5]
execute 'sfdisk 5' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

# Create ASM disks
devSuffix='1'

diskDev=node[:diskDev1]
asmDisk=node[:grddgDisk1]
execute 'create asm disk 1' do
  user "root"
  command "oracleasm createdisk #{asmDisk} #{diskDev}#{devSuffix}"
end

diskDev=node[:diskDev2]
asmDisk=node[:grddgDisk2]
execute 'create asm disk 2' do
  user "root"
  command "oracleasm createdisk #{asmDisk} #{diskDev}#{devSuffix}"
end

diskDev=node[:diskDev3]
asmDisk=node[:grddgDisk3]
execute 'create asm disk 3' do
  user "root"
  command "oracleasm createdisk #{asmDisk} #{diskDev}#{devSuffix}"
end

diskDev=node[:diskDev4]
asmDisk=node[:grddgDisk4]
execute 'create asm disk 4' do
  user "root"
  command "oracleasm createdisk #{asmDisk} #{diskDev}#{devSuffix}"
end

diskDev=node[:diskDev5]
asmDisk=node[:grddgDisk5]
execute 'create asm disk 5' do
  user "root"
  command "oracleasm createdisk #{asmDisk} #{diskDev}#{devSuffix}"
end

execute 'mounting asm disks on node2' do
  user "root"
  command "sshpass -p #{node[:rootPassword]} ssh -o StrictHostKeyChecking=no root@#{node[:hostnameNode2]} oracleasm scandisks > /tmp/asmdisk.mount.node2.out"
end

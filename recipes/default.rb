#
# Cookbook Name:: cbora12crac1
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# RUN ORDER
# First run these on node1
#users_and_groups.rb --> create one and run if users and groups are not there in the machine
#setup_ssh.rb
#directories.rb
#update_etc_hosts.rb
#configure_oracleasm.rb
#prepare_asm_disks.rb
#Then run grid runinstaller manually (recipe not coded yet)

# Then run these on node2
#users_and_groups.rb --> create one and run if users and groups are not there in the machine
#directories.rb
#update_etc_hosts.rb
#configure_oracleasm.rb
#(DO NOT run prepare_asm_disks.rb)

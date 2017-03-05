#
#
# setup_ssh_grid.rb

#  CAUTION - UNDERSTAND THIS CORRETLY AND REWRITE.  IT IS MESSING UP AND NOT REALLY SETTING THE PASSWORD TO WHAT WE WANTED
#
# Set password (for productionizing, this cannot be this simple!)
#
#  CAUTION - UNDERSTAND THIS CORRETLY AND REWRITE.  IT IS MESSING UP AND NOT REALLY SETTING THE PASSWORD TO WHAT WE WANTED
#

gridUser=node[:gridUser]
groupToUse=node[:oinstallGroup]
gridPassword=node[:gridPassword]

# User equivalence - oracle - do on both nodes one after the other
bash 'set up ssh key' do
  user "#{gridUser}"
  group "#{groupToUse}"

  code <<-EOH

    thisHost=`hostname`
    homedir=`grep #{gridUser} /etc/passwd | cut -d: -f6`
    sshdir=${homedir}/.ssh

    cd $homedir
    mkdir -p .ssh

    ssh-keygen -t rsa -f $sshdir/id_rsa -q -P ""
    cd $sshdir
    cat id_rsa.pub >> authorized_keys

    if [ "$thisHost" == "#{node[:hostnameNode1]}" ]
    then

        echo sshpass -p "#{node[:gridPassword]}" ssh -o StrictHostKeyChecking=no "#{gridUser}"@"#{node[:hostnameNode2]}" /bin/mkdir -p $sshdir > /home/grid/run.mkdir
        sshpass -p "#{node[:gridPassword]}" ssh -o StrictHostKeyChecking=no "#{gridUser}"@"#{node[:hostnameNode2]}" /bin/mkdir -p $sshdir > /home/grid/out.mkdir 2>> /home/grid/out.mkdir

        # Do a ssh to self and remote machine - so that one can ssh to itself and remote host
        sshpass -p "#{node[:gridPassword]}" ssh -o StrictHostKeyChecking=no "#{gridUser}"@"#{node[:hostnameNode1]}" date
        sshpass -p "#{node[:gridPassword]}" ssh -o StrictHostKeyChecking=no "#{gridUser}"@"#{node[:hostnameNode2]}" date


        cd $sshdir
        echo sshpass -p "#{node[:gridPassword]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{gridUser}"@"#{node[:hostnameNode2]}":${sshdir}/. > /home/grid/run.scp
        sshpass -p "#{node[:gridPassword]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{gridUser}"@"#{node[:hostnameNode2]}":${sshdir}/. > /home/grid/out.scp 2>> /home/grid/out.scp

    else


        # Do a ssh to self and remote machine - so that one can ssh to itself and remote host
        sshpass -p "#{node[:gridPassword]}" ssh -o StrictHostKeyChecking=no "#{gridUser}"@"#{node[:hostnameNode1]}" date
        sshpass -p "#{node[:gridPassword]}" ssh -o StrictHostKeyChecking=no "#{gridUser}"@"#{node[:hostnameNode2]}" date


        cd $sshdir
        echo sshpass -p "#{node[:gridPassword]}" scp -o StrictHostKeyChecking=no -r authorized_keys "#{gridUser}"@"#{node[:hostnameNode1]}":${sshdir}/. > /home/grid/run.scp
        sshpass -p "#{node[:gridPassword]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{gridUser}"@"#{node[:hostnameNode1]}":${sshdir}/. > /home/grid/out.scp 2>> /home/grid/out.scp


    fi

  EOH
end

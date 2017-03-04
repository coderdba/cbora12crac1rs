#
#
# setup_ssh.rb

#  CAUTION - UNDERSTAND THIS CORRETLY AND REWRITE.  IT IS MESSING UP AND NOT REALLY SETTING THE PASSWORD TO WHAT WE WANTED
#
# Set password (for productionizing, this cannot be this simple!)
#
#  CAUTION - UNDERSTAND THIS CORRETLY AND REWRITE.  IT IS MESSING UP AND NOT REALLY SETTING THE PASSWORD TO WHAT WE WANTED
#

dbUser=node[:dbUser]
groupToUse=node[:oinstallGroup]
oraclePassword=node[:oraclePassword]

# User equivalence - oracle - do on both nodes one after the other
bash 'set up ssh key' do
  user "#{dbUser}"
  group "#{groupToUse}"

  code <<-EOH

    thisHost=`hostname`
    homedir=`grep #{dbUser} /etc/passwd | cut -d: -f6`
    sshdir=${homedir}/.ssh

    cd $homedir
    mkdir -p .ssh

    ssh-keygen -t rsa -f $sshdir/id_rsa -q -P ""
    cd $sshdir
    cat id_rsa.pub >> authorized_keys

    if [ "$thisHost" == "#{node[:hostnameNode1]}" ]
    then

        echo sshpass -p "#{node[:oraclePassword]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode2]}" /bin/mkdir -p $sshdir > /home/oracle/run.mkdir
        sshpass -p "#{node[:oraclePassword]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode2]}" /bin/mkdir -p $sshdir > /home/oracle/out.mkdir 2>> /home/oracle/out.mkdir

        # Do a ssh to self and remote machine - so that one can ssh to itself and remote host
        sshpass -p "#{node[:oraclePassword]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode1]}" date
        sshpass -p "#{node[:oraclePassword]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode2]}" date


        cd $sshdir
        echo sshpass -p "#{node[:oraclePassword]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode2]}":${sshdir}/. > /home/oracle/run.scp
        sshpass -p "#{node[:oraclePassword]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode2]}":${sshdir}/. > /home/oracle/out.scp 2>> /home/oracle/out.scp

    else


        # Do a ssh to self and remote machine - so that one can ssh to itself and remote host
        sshpass -p "#{node[:oraclePassword]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode1]}" date
        sshpass -p "#{node[:oraclePassword]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode2]}" date


        cd $sshdir
        echo sshpass -p "#{node[:oraclePassword]}" scp -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode1]}":${sshdir}/. > /home/oracle/run.scp
        sshpass -p "#{node[:oraclePassword]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode1]}":${sshdir}/. > /home/oracle/out.scp 2>> /home/oracle/out.scp


    fi

  EOH
end

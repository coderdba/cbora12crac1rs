#
#
#  Default attributes file for RAC on Linux VM
#
#
#

# Users and Groups
#  NOTE:  Password hash is for setting password using 'user' resource (like oraclePasswordHash)
#         The other like oraclePassword is the actual password

# Software Owner Users
default['gridUser'] = 'grid'
default['dbUser']   = 'oracle'

# Install group - assign to all software-owners
default['oinstallGroup']  = 'oinstall'

# DB Software Groups
default['osdbaGroup']     = 'dba'
default['osoperGroup']    = 'oraoper'
default['osbackupdbaGroup'] = 'orabkupdba'

# Grid/ASM Groups
default['asmadminGroup']  = 'asmadmin'
default['asmdbaGroup']    = 'asmdba'
default['asmoperGroup']    = 'asmoper'

# Passwords
default['oraclePassword'] = 'oracle'
default['gridPassword'] = 'oracle'
default['oraclePasswordHash'] = ''
default['rootPassword']   = 'root'

# Directories
default['oraBase']['rootDir']    = '/u01'
default['oraBase']['appDir']     = '/u01/app'
default['oraBase']['dirName']    = '/u01/app/oracle'
default['oraInventory']['dirName']  = '/u01/app/oraInventory'
default['gridHome']['dirName']      = '/u01/app/gridhome12c'
default['gridBase']['dirName']      = '/u01/app/gridbase'

# Directory Ownership
default['oraBase']['dirOwner']     = 'oracle'
default['oraInventory']['dirOwner']   = 'grid'
default['gridHome']['dirOwner']       = 'grid'
default['gridBase']['dirOwner']       = 'grid'

# Directory Group - usually the 'install' group (if no separate install group, then usually the osdba group)
default['oraBase']['dirGroup']     = 'oinstall'
default['oraInventory']['dirGroup']   = 'oinstall'
default['gridHome']['dirGroup']       = 'oinstall'
default['gridBase']['dirGroup']       = 'oinstall'

# Directory Permission
default['oraBase']['dirPerm']    = '755'
default['oraInventory']['dirPerm']  = '775'
default['gridHome']['dirPerm']      = '755'
default['gridBase']['dirPerm']      = '755'

# Cluster Name
default['clusterName'] = 'rac1'

# Host Names
default['hostnameNode1'] = 'rac1n1'
default['hostnameNode2'] = 'rac1n2'

# Software staging area
default['softwareLocation']['grid'] = '/stage-grid'
default['softwareLocation']['db'] = '/stage-db'

# IP Addresses
# Public
default['publicIpNode1'] = '192.168.0.111'
default['publicIpNode2'] = '192.168.0.112'

# Virtual
default['virtualIpNode1'] = '192.168.0.121'
default['virtualIpNode2'] = '192.168.0.122'

# Private Interconnect
default['privateIpNode1'] = '10.10.10.111'
default['privateIpNode2'] = '10.10.10.112'

# SCAN
default['scanIp1'] = '192.168.0.131'
default['scanIp2'] = '192.168.0.132'
default['scanIp3'] = '192.168.0.133'

# Hosts File
default['hostsFile'] = '/etc/hosts'

# Disks
default['diskDev1'] = '/dev/sdb'
default['diskDev2'] = '/dev/sdc'
default['diskDev3'] = '/dev/sdd'
default['diskDev4'] = '/dev/sde'
default['diskDev5'] = '/dev/sdf'

# fdisk format file
default['sfdisk2gb_format_file']      = '/tmp/sfdisk_2gb.format'
default['sfdisk2gb_format_template']  = 'sfdisk_2gb.erb'

# ASM Grid disk group disk Names
default['grddgDisk1'] = 'DISK01'
default['grddgDisk2'] = 'DISK02'
default['grddgDisk3'] = 'DISK03'
default['grddgDisk4'] = 'DISK04'
default['grddgDisk5'] = 'DISK05'

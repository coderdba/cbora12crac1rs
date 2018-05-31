useradd -u 54323 -g oinstall grid
usermod -a -G asmdba grid
usermod -a -G asmadmin grid
id grid

# now the result should be:
#uid=54323(grid) gid=54321(oinstall) groups=54321(oinstall),54333(asmadmin),54334(asmdba)

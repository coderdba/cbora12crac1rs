# Create groups
group 'oinstall' do
  action :create
  gid 54321
end

group 'dba' do
  action :create
  gid 54322
end

group 'asmadmin' do
  action :create
  gid 54333
end

group 'asmdba' do
  action :create
  gid 54334
end

group 'asmoper' do
  action :create
  gid 54335
end

# create users
user 'oracle' do
  group 'oinstall'
  uid 54321
  action :create
end

user 'grid' do
  group 'oinstall'
  uid 54323
  action :create
end

# assign additional groups to users
group 'asmdba' do
  action :modify
  members 'oracle'
  append true
end

group 'dba' do
  action :modify
  members 'oracle'
  append true
end

%w{asmadmin asmdba }.each do |g|
  group g do
    action :modify
    members 'grid'
    append true
  end
end

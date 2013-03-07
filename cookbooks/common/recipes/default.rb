#
# = Linux common packages
#

#
# yum update
#
execute "yum update" do
  command "yum -y update"
end

#
# Package install
#

execute "yum groupinstall Desktop" do
  command "yum -y groupinstall Desktop"
end

package "wget" do
  action :install
  not_if "rpm -q wget"
end

package "man" do
  action :install
  not_if "rpm -q man"
end

package "gcc" do
  action :install
  not_if "rpm -q gcc"
end

package "make" do
  action :install
  not_if "rpm -q make"
end

package "vim" do
  action :install
  not_if "rpm -q vim"
end

package "perl" do
  action :install
  not_if "rpm -q perl"
end

package "firefox" do
  action :install
  not_if "rpm -q firefox"
end

package "kernel-devel" do
  action :install
  not_if "rpm -q kernel-devel"
end


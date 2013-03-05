#
# = Linux common packages
#

#
# yum update
#
execute "yum update" do
  command "yum update"
end

#
# Package install
#

execute "yum groupinstall X Window System" do
  command "yum groupinstall X Window System"
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


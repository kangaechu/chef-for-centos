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

package "wget" do
  action :install
  not_if "rpm -q wget"
end

package "man" do
  action :install
  not_if "rpm -q man"
end

package "unzip" do
  action :install
  not_if "rpm -q unzip"
end

package "vim" do
  action :install
  not_if "rpm -q vim"
end

package "perl" do
  action :install
  not_if "rpm -q perl"
end

#
# = Linux Desktop package install
#

execute "yum groupinstall Desktop" do
  command "yum -y groupinstall Desktop"
end

package "firefox" do
  action :install
  not_if "rpm -q firefox"
end


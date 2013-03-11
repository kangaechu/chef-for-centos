#
# = Virtualbox Guest Additionsプラグイン
#

#
# Package install
#
# install required packages

package "gcc" do
  action :install
  not_if "rpm -q gcc"
end

package "make" do
  action :install
  not_if "rpm -q make"
end

package "kernel-devel" do
  action :install
  not_if "rpm -q kernel-devel"
end


# get latest Virtualbox Guest Additions version

versionServer = `curl http://download.virtualbox.org/virtualbox/LATEST.TXT`.strip
filename = "VBoxGuestAdditions_#{versionServer}"

remote_file "#{Chef::Config[:file_cache_path]}/#{filename}.iso" do
  source "http://download.virtualbox.org/virtualbox/#{versionServer}/#{filename}.iso"
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/#{filename}.iso") or
          File.exists?("/opt/VBoxGuestAdditions-" + versionServer + "/bin")}
end

bash "install Virtualbox Guest Additions" do
  user "root"
  cwd "/tmp"
  flags "-x -e"
  code <<-EOH
  mkdir -p /mnt/#{filename}
  mount #{filename}.iso -o loop /mnt/#{filename}
  sh /mnt/#{filename}/VBoxLinuxAdditions.run --nox11
  umount /mnt/#{filename}
  rmdir /mnt/#{filename}
  rm -rf #{filename}.iso
  EOH
  not_if {! File.exists?("#{Chef::Config[:file_cache_path]}/#{filename}.iso") or
          File.exists?("/opt/VBoxGuestAdditions-" + versionServer + "/bin")}
end

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

versionServer=`wget -q -O - http://download.virtualbox.org/virtualbox/LATEST.TXT`

bash "install Virtualbox Guest Additions" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  FILENAME="VBoxGuestAdditions_#{versionServer}"
  wget -c http://download.virtualbox.org/virtualbox/#{versionServer}/${FILENAME}.iso -O ${FILENAME}.iso
  mkdir -p /mnt/${FILENAME}
  mount ${FILENAME}.iso -o loop /mnt/${FILENAME}
  sh /mnt/${FILENAME}/VBoxLinuxAdditions.run --nox11
  umount /mnt/${FILENAME}
  rm -rf ${FILENAME}.iso
  EOH
  not_if {File.exists?("/opt/VBoxGuestAdditions_" + versionServer)}
end

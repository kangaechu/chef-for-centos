#
# = Openssh server
#

#
# Package install
#

package "openssh-server" do
  action :install
  not_if "rpm -q openssh-server"
end

#
# open iptables port
#
iptables_rule "ssh"

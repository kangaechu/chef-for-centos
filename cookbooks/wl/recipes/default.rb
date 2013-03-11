#
# = Worklight Server
#

#
# Package install
#

bash "Install Worklight Server" do
  user "root"
  cwd "/tmp"
  flags "-x -e"
  code <<-EOH
	ls
  EOH
  not_if {File.exists?("/opt/IBM/Worklight")}
end

#
# = Worklight Server
#

#
# Package install
#

filenameInstMgr = "ENT_DEPLOY_1.6_LINUX_X86_64.zip"
filenameWLServer = "IM_Rep_Worklight_Server_wee_5.0.5.zip"

#
# Package install
#
# install required packages

package "unzip" do
  action :install
  not_if "rpm -q unzip"
end

bash "Install Installation Manager" do
  user "root"
  cwd "/tmp"
  flags "-x -e"
  code <<-EOH
    INSTDATE=`date "+%Y%m%d-%H%M"`
    rm -rf /tmp/EnterpriseCD-Linux-x86_64
    unzip -q #{Chef::Config[:file_cache_path]}/#{filenameInstMgr}
    cd EnterpriseCD-Linux-x86_64/InstallationManager
    ./install --launcher.ini silent-install.ini -log /tmp/InstallationManager-${INSTDATE}.log -acceptLicense
    rm -rf /tmp/EnterpriseCD-Linux-x86_64
  EOH
  not_if {File.exists?("/opt/IBM/InstallationManager")}
end

template "/tmp/responseFile.xml" do
  source "responseFile.xml.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/tmp/createdb-mysql.sql" do
  source "createdb-mysql.sql.erb"
  owner "root"
  group "root"
  mode "0644"
end

bash "Create Worklight Databases" do
  user "root"
  cwd "/tmp"
  flags "-x -e"
  code <<-EOH
    mysql -u root < /tmp/createdb-mysql.sql
    rm -f /tmp/createdb-mysql.sql
  EOH
  not_if {File.exists?("/opt/IBM/Worklight")}
end



bash "Install Worklight Server" do
  user "root"
  cwd "/tmp"
  flags "-x -e"
  code <<-EOH
    INSTDATE=`date "+%Y%m%d-%H%M"`
    cp #{Chef::Config[:file_cache_path]}/#{node[:wl][:mysql][:driver]} /tmp
    rm -rf /tmp/Worklight
    unzip -q #{Chef::Config[:file_cache_path]}/#{filenameWLServer}
    cd /opt/IBM/InstallationManager/eclipse
    ./IBMIM --launcher.ini silent-install.ini -input /tmp/responseFile.xml -log /tmp/WLServer-${INSTDATE}.xml -acceptLicense
    rm -rf /tmp/Worklight
    rm /tmp/#{node[:wl][:mysql][:driver]}
  EOH
  not_if {File.exists?("/opt/IBM/Worklight")}
end


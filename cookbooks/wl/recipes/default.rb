#
# Cookbook Name:: IBM Worklight Server
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

filenameInstMgr = "ENT_DEPLOY_1.6_LINUX_X86_64.zip"
filenameWLServer = "IM_Rep_Worklight_Server_wee_5.0.6.zip"

package "unzip" do
  action :install
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
  flags "-x"
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
    cp -f #{Chef::Config[:file_cache_path]}/#{node[:wl][:mysql][:driver]} /tmp
    rm -rf /tmp/Worklight
    unzip -q #{Chef::Config[:file_cache_path]}/#{filenameWLServer}
    cd /opt/IBM/InstallationManager/eclipse
    ./IBMIM --launcher.ini silent-install.ini -input /tmp/responseFile.xml -log /tmp/WLServer-${INSTDATE}.xml -acceptLicense
    rm -rf /tmp/Worklight
    rm /tmp/#{node[:wl][:mysql][:driver]}
  EOH
  not_if {File.exists?("/opt/IBM/Worklight")}
end

template "#{node[:wl][:tomcat][:installdir]}/conf/Catalina/localhost/worklight.xml" do
  source "worklight.xml.erb"
  owner "tomcat"
  group "tomcat"
  mode "0644"
end


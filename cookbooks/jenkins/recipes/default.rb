#
# = Jenkins リポジトリの追加 + パッケージインストール
#

#
# Package install
#
# jenkins
bash "jenkins-key" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
  rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
  EOH
  not_if "yum repolist | grep -i jenkins"
end

package "jenkins" do
  action :install
  not_if "rpm -q jenkins"
end

#
# chkconfig
#
execute "chkconfig jenkins on" do
  command "chkconfig jenkins on"
end

#
# command
#
service "jenkins" do
  stop_command    "/etc/init.d/jenkins stop"
  start_command   "/etc/init.d/jenkins start"
  restart_command "/etc/init.d/jenkins graceful"
  action :start
end

#
# Cookbook Name:: wl
# Attributes:: default

default["wl"]["arch"] = "x86_64"

default["wl"]["database"]["selection"] = "mysql"
default["wl"]["database"]["preinstalled"] = "true"

default["wl"]["mysql"]["host"] = "localhost"
default["wl"]["mysql"]["port"] = 3306
default["wl"]["mysql"]["username"] = "worklight"
default["wl"]["mysql"]["password2"] = "worklight"
default["wl"]["mysql"]["driver"] = "mysql-connector-java-5.1.21-bin.jar"

default["wl"]["appserver"]["selection"] = "tomcat"
default["wl"]["tomcat"]["installdir"] = "/usr/local/tomcat/base"

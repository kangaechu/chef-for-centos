name "web"
description ""
run_list(
  "role[base]",
#  "recipe[Desktop]",
  "recipe[virtualbox]",
  "recipe[java]",
  "recipe[mysql]",
  "recipe[tomcat]",
  "recipe[wl]"
)

default_attributes({
  :role                => "web",
})
name "web"
description ""
run_list(
  "role[base]",
  "recipe[Desktop]",
  "recipe[Virtualbox]",
  "recipe[java]",
  "recipe[jenkins]"
)

default_attributes({
  :role                => "web",
})
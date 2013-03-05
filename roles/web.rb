name "web"
description ""
run_list(
  "role[base]",
  "recipe[java]",
  "recipe[jenkins]"
)

default_attributes({
  :role                => "web",
})
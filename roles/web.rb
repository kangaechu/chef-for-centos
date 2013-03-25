name "web"
description ""
run_list(
  "role[base]",
  "recipe[iptables]",
  "recipe[ssh]",
  "recipe[virtualbox]",
  "recipe[java]",
  "recipe[mysql]",
  "recipe[tomcat]",
  "recipe[wl]"
)

default_attributes({
  :role  => "web",

  # JavaでOracle JDKをインターネットから自動ダウンロードする
  :java => {
  	"install_flabor" => "oracle",
  	"jdk_version" => "7",
  	:oracle => {
  		"accept_oracle_download_terms" => true
  	}
  }
})

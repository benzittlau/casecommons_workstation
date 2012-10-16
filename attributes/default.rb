default[:ruby_runner] = "rvm"
default[:current_path] = [ENV['PATH'], (node[:current_path] || ""), "#{WS_HOME}/.rvm/bin"].join(":")
default[:rvm][:version] = "1.9.3-p125"
default[:github][:api][:login] = ENV["GITHUB_LOGIN"]
default[:github][:api][:password] = ENV["GITHUB_PASSWORD"]
default[:github][:api][:keys_url] = "https://api.github.com/user/keys"
default[:github][:api][:add_url] = "https://api.github.com/user/keys"
default[:github][:api][:token] = ENV["GITHUB_TOKEN"]
default[:apple][:domain] = "com.apple"

default[:logout_marker] = "/tmp/__logout_required"
default[:brewstrap][:src] = "https://raw.github.com/schubert/brewstrap/master/brewstrap.sh"

default[:firefox][:version] = "10.0.5esr"
default[:firefox][:checksum] = "745a420c9915dc87b74fcde2c0b301b39b7031f5b9365c27b734b079cfda9026"


default[:rebrewstrap_plist] = "/Library/LaunchDaemons/com.pivotal.rebrewstrap.plist"
default[:rebrewstrap_plist_deprecated] = "/Library/LaunchAgents/com.pivotal.rebrewstrap.plist"

default[:postgres][:version] = "9.1.5" ## 9.16 does not yet exist
default[:postgres][:sha] = "6b8d25f" ## sha for homebrew

default[:brew][:version] = "0.9.2"

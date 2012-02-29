default[:current_path] = [ENV['PATH'], (node[:current_path] || ""), "#{WS_HOME}/.rvm/bin"].join(":")
default[:rvm][:version] = "1.9.2"

default[:github][:api][:login] = ENV["GITHUB_LOGIN"]
default[:github][:api][:keys_url] = "https://api.github.com/user/keys"
default[:github][:api][:add_url] = "https://api.github.com/user/keys"
default[:github][:api][:token] = ENV["GITHUB_TOKEN"]
default[:apple][:domain] = "com.apple"
default[:postgres][:version] = "9.1.2"
default[:postgres][:sha] = "94995df0f936674a11274e9d4f9257051ce8867f"

default[:logout_marker] = "/tmp/__logout_required"
default[:brewstrap][:src] = "https://raw.github.com/schubert/brewstrap/master/brewstrap.sh"

default[:firefox][:version] = "10.0.2"
default[:firefox][:checksum] = "3cac4e93900bb8a1f03c6cbfb9b24a84583f1476aa90d912b25a7d98464a57d8"


default[:rebrewstrap_plist] = "/Library/LaunchDaemons/com.pivotal.rebrewstrap.plist"
default[:rebrewstrap_plist_deprecated] = "/Library/LaunchAgents/com.pivotal.rebrewstrap.plist"

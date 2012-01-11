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

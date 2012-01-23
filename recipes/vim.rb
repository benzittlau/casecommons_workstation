homebrew "mercurial"

homebrew "vim" do
  formula "https://raw.github.com/pivotal-casebook/microbrew/master/vim.rb"
end

# execute "uninstall-macvim" do
  # command "brew uninstall macvim"
# end
# homebrew "macvim" do
  # pre_command "rvm use system"
  # formula "https://raw.github.com/pivotal-casebook/microbrew/master/macvim.rb"
# end

vim_dir = "#{WS_HOME}/.vim"
execute "remove-existing-vim-config-link-to-dropbox" do
  only_if "test -L #{vim_dir}"
  command "rm -rf #{vim_dir}"
end

execute "nuke bad .vim if no vimrc is there" do
  not_if "test -e #{vim_dir}/.git"
  command "rm -rf #{vim_dir}"
end

execute "remove pivotal config" do
  command "rm -rf #{vim_dir}"
end

git "our-own-#{vim_dir}" do
  destination vim_dir
  only_if "true"
  repository "git@github.com:Casecommons/vim-config.git"
  action :sync
  user WS_USER
  enable_submodules true
end

execute "verify-checkout-happened" do
  command "test -e #{vim_dir}"
end

execute "reset vim config from git" do
  only_if "test -d #{vim_dir}"
  user WS_USER
  command <<-SH
    cd #{WS_HOME}/.vim
    git fetch
    git reset --hard origin/master
    git submodule sync
    git submodule update
  SH
end

file "/Users/#{WS_USER}/.vimrc.local" do
  action :touch
  owner WS_USER
end

define :homebrew, formula: nil do
  formula = params[:formula] || params[:name]

  pre_command = params[:pre_command] ? "#{params[:pre_command]} && " : ""

  execute "homebrew-install-#{params[:name]}" do
    command "#{pre_command}(brew install #{formula} || brew upgrade #{formula} && brew linkapps)"
    user WS_USER
    ignore_failure true
  end
end

namespace 'config' do
  desc "Print config"
  task :print do
    pp cfg.to_h
  end
end

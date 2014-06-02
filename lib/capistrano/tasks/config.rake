namespace 'config' do
  desc "Print config"
  task :print do
    pp settings_to_h
  end
end

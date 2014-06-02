namespace 'rails_devise' do
  desc 'Upload database.yml and secrets.yml'
  task :upload_config do
    on roles(:application) do
      ['database', 'secrets'].each do |f|
        upload! template("rails-devise/#{f}.yml.erb"), release_path.join('config', "#{f}.yml")
      end
    end
  end
end

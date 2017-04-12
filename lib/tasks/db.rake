namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke
    puts "Creating Company"
    puts "Creating Place"
  end
end

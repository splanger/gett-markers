namespace :gett do

  DRIVERS_JSON = 'drivers.json'
  METRICS_JSON = 'metrics.json'

  desc "Imports all drivers from 'db/driver.json' file"
  task :import_drivers => :environment do
    puts 'Importing drivers'

    # Read seed data from a JSON file
    seeds = seeds_from_json_file(DRIVERS_JSON)

    # Save all seeds in DB using a model
    seeds.each do |seed|
      if seed['id'] != nil
        begin
          Driver.create! seed
          puts "Imported a new driver: #{seed}"
        rescue ActiveRecord::RecordNotUnique
          puts "Driver with ID #{seed['id']} already exists"
        end
      end
    end
  end

  def seeds_from_json_file(seed_filename)
    # Read seed data from a JSON file
    data_file = File.join(data_path, seed_filename)
    json = File.read(data_file)
    JSON.parse(json)
  end

  def data_path
    File.expand_path(
      File.join(
          File.dirname(File.dirname(File.dirname(__FILE__))),
          'db'
      )
    )
  end
end
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

  desc "Imports all metrics from 'db/metrics.json' file"
  task :import_metrics => :environment do
    puts 'Importing metrics'

    data_file = File.join(data_path, METRICS_JSON)

    num_imported = 0
    num_ignored = 0
    File.open(data_file).each do |line|
      seed = JSON.parse(line.chomp)

      if seed['driver_id'] != nil and seed['timestamp'] != nil
        seed['timestamp'] = Time.at(seed['timestamp']).utc.to_s

        begin
          driver = Driver.find(seed['driver_id'])
        rescue ActiveRecord::RecordNotFound
          #puts "The driver (ID #{seed['driver_id']})related to a metric doesn't exist."\
          #      'Ignoring the metric.'
          num_ignored += 1
          next
        end

        begin
          driver.metrics.create! seed
          num_imported += 1
          puts "Imported: #{seed}"
        rescue ActiveRecord::RecordNotUnique
          # puts 'Ignoring the metric. Such a metric already exists.'
          # puts "  > seed(exists) = #{seed}"
          num_ignored += 1
        end
      end
    end

    puts "Finished importing metrics. (Imported: #{num_imported} | Ignored: #{num_ignored})"
  end

  desc 'Imports all drivers and metrics'
  task :import => [:import_drivers, :import_metrics]

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
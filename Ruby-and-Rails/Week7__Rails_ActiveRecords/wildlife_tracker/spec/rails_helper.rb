# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

class BackForest
  def initialize
    Sight.destroy_all
    Region.destroy_all
    Animal.destroy_all

    @animals_specs = %w[Baboon Weasel Sailcat Jellyfish Rattlesnake]
    @animals_specs.each { |spec| Animal.create(species: spec) }
    @animal = Animal.all.first

    @regions_names = %w[Circle Square Leftovers]
    @regions = @regions_names.map { |name| Region.create(name: name) }

    @sights_data = [
      { species: 'Weasel', region_name: 'Circle', location: [32.98241, 43.23493], date: '12 Jan 2017' },
      { species: 'Baboon', region_name: 'Circle', location: [30.82376, 40.23493], date: '21 Feb 2017' },
      { species: 'Sailcat', region_name: 'Square', location: [33.23442, 40.23493], date: '13 Jan 2017' },
      { species: 'Weasel', region_name: 'Leftovers', location: [32.82376, 42.28783], date: '19 Feb 2018' },
      { species: 'Baboon', region_name: 'Leftovers', location: [31.768341, 42.98834], date: '31 Jul 2019' },
      { species: 'Sailcat', region_name: 'Circle', location: [35.98354, 40.89223], date: '11 Aug 2019' },
      { species: 'Weasel', region_name: 'Square', location: [32.12524, 42.78252], date: '08 Dec 2019' },
      { species: 'Sailcat', region_name: 'Leftovers', location: [34.34753, 42.67587], date: '04 May 2020' },
      { species: 'Baboon', region_name: 'Leftovers', location: [33.49709, 42.57982], date: '17 Sep 2021' },
      { species: 'Weasel', region_name: 'Circle', location: [30.28937, 42.2798], date: '23 Jun 2022' },
      { species: 'Sailcat', region_name: 'Square', location: [33.90411, 41.76813], date: '25 Jul 2023' }
    ]
    animals = Animal.all.map { |animal| [animal.species, animal] }.to_h
    regions_ids = Region.all.map { |region| [region.name, region.id] }.to_h
    @sights_data.each do |record|
      record[:region_id] = regions_ids[record[:region_name]]
      animals[record[:species]].sights.create(record.except(:species, :region_name))
    end
  end
end

# frozen_string_literal: true
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'active_record'
require 'fileutils'

include ActiveRecord::Tasks

RSpec::Core::RakeTask.new(:spec)

db_dir = File.expand_path('../db', __FILE__)
config_dir = File.expand_path('../config', __FILE__)

DatabaseTasks.env = ENV['ENV'] || 'development'
DatabaseTasks.db_dir = db_dir
DatabaseTasks.database_configuration =
  YAML.load_file(File.join(config_dir, 'database.yml'))
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection(
    DatabaseTasks.database_configuration[DatabaseTasks.env]
  )
end

load 'active_record/railties/databases.rake'

RuboCop::RakeTask.new

task(default: [:rubocop, :spec])

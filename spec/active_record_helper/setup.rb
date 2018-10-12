ActiveRecord::Base.configurations = {
  "postgresql" => {
    "adapter" => 'postgresql',
    "host" => 'localhost',
    "database" => 'batcher_tests',
    "encoding" => 'utf8',
    "username" => ENV["DATABASE_POSTGRESQL_USERNAME"] || `whoami`.strip,
    "password" => ENV["DATABASE_POSTGRESQL_PASSWORD"],
  },
}

env = ENV['DATABASE'] ||= 'postgresql'
config = ActiveRecord::Base.configurations[env]

case env
when 'postgresql'
  ActiveRecord::Tasks::DatabaseTasks.instance_variable_set('@env', env)
  ActiveRecord::Tasks::DatabaseTasks.drop_current
  ActiveRecord::Tasks::DatabaseTasks.create_current
  ActiveRecord::Tasks::DatabaseTasks.load_schema_current(:ruby, File.expand_path('../schema.rb', __FILE__))
  ActiveRecord::Base.establish_connection(config)
else
  raise ArgumentError, 'Unrecognized ENV["DATABASE"] argument.'
end

require_relative 'thing'

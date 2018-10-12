ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :things do |t|
    t.integer :a
    t.integer :b
  end
end

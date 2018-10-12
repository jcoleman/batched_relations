# BatchedRelations 

[![Build Status](https://semaphoreci.com/api/v1/jcoleman/batched_relations/branches/master/badge.svg)](https://semaphoreci.com/jcoleman/batched_relations)

BatchedRelations simplifies writing performant batched queries in ActiveRecord with PostgreSQL.

While ActiveRecord supports easy batching of queries (e.g., `ActiveRecord::Relation#find_in_batches`), that batching very frequently a cause of query performance problems. Native ActiveRecord batching requires that the query order by the table's primary key, but this requirement is often in direct opposition to the kind of query execution plan is optimal for the un-ordered portion of the query. For example, suppose you had a table like:

```
create_table(:things) do |t|
  t.text "status"
  t.timestamps
end

add_index :things, [:status, :created_at]
```

and the query:

```
Thing
  .where(status: "paid")
  .where(["created_at > ?", Time.now - 24.hours])
```

The obvious execution plan for that query is to find the subtree of the `(status, created_at)` index that matches `status = 'paid'` and then scan that index for the requested date range. If this brings back too many records to process efficiently, we could break up the query into chunks of that date range. But if we force ordering by the primary key, then the database is required to find all matching results, order those results by the primary key, and then apply our limit.

Instead, we'd prefer to use an ordering that matches our performant query execution plan. In this case, we need to order by `created_at`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'batched_relations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install batched_relations

## Contributing

1. Fork it ( https://github.com/jcoleman/relation_to_struct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Test your changes (`bundle install && appraisal install && rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

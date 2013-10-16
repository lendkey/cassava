Cassava
=========

Cassava is an object oriented approach to CSV generation. Compared to traditional array based CSV generation there is much less work to make changes and much more automated.

## Array Based

```ruby
CSV.open("filename", "w") do |csv|
  csv.add_row ['a', 'b', 'c']
  Object.all.each do |o|
    csv.add_row [o.a, o.b, o.c]
  end
end
```

## Cassava

```ruby
Cassava::Builder.build do
  set_path 'file_name'
  add_column :a, 'a'
  add_column :b, 'b'
  add_column :c, 'c'
  add_rows Object.all
end
```

This doesn't look like much with such small CSVs, but as your CSV column length grows into the double digits, you will be glad you don't need to coordinate the two arrays.

EasyCSV
=========

EasyCSV is an object oriented approach to CSV generation. Compared to traditional array based CSV generation there is much less work to make changes and much more automated.

## Array Based

```ruby
CSV.open("filename", "w") do |csv|
  csv.add_row ['a', 'b', 'c']
  Object.all.each do |o|
    csv.add_row [o.a, o.b, o.c]
  end
end
```

## EasyCSV

```ruby
EasyCSV::Builder.build do
  write_to_file 'file_name'
  add_column :a, 'a'
  add_columns [[:b, 'b'], [:c, 'c']]
  add_rows Object.all
end
```

This doesn't look like much with such small CSVs, but as your CSV column length grows into the double digits, you will be glad you don't need to coordinate the two arrays.

## Advanced CSV making
Making a CSV is much like making a view, so view patterns are very helpful here.

### Exhibits
Say you want to have multiple models on the same CSV. In order to achieve this you will need to use an exhibit pattern.

```ruby
User = Struct.new(:name)
Address = Struct.new(:street, :city)

class ReportCSVExhibit < Struct.new(:user, :address)
  def username; user.name; end
  def street; address.street; end
  def city; address.city; end
end

user = User.new 'Bob'
address = Address.new 'Main St', 'New York'

EasyCSV::Builder.build do
  write_to_file('/tmp/report.csv')
  add_column(:username, 'Name')
  add_column(:street, 'Street')
  add_column(:city, 'City')
  add_row(ReportCSVExhibit.new(user, address)
end
```

### Presenters
If you otherwise need to change data from the original data models use a presenter.

```ruby
User = Struct.new(:first_name, :last_name)

class UserPresenter < SimpleDelegator
  def full_name
    "#{first_name} #{last_name}"
  end
end

user = User.new 'Bob', 'Doe'

EasyCSV::Builder.build do
  write_to_file('/tmp/users.csv')
  add_column(:full_name, "Name")
  add_row(UserPresenter.new(user))
end
```
### Output
EasyCSV returns a string representation of the built CSV. If you do not wish to write to a file then omit #write_to_file while setting up the builder.

If you want to write to multiple files simply call #write_to_file multiple times.

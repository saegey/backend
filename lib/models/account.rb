class Account < Sequel::Model
  one_to_many :users
  one_to_many :properties
  plugin :timestamps
end

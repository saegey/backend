class Account < Sequel::Model
  one_to_many :user
  one_to_many :properties
  plugin :timestamps
end

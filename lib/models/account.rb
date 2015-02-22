class Account < Sequel::Model
  one_to_one :user
  one_to_many :properties
  plugin :timestamps
end

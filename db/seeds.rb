# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# A Sequel database connection can be obtained via Sequel::Model.db
require "bundler"
Bundler.require(:default, :test)

require 'dotenv'
Dotenv.load('.env.test')

require_relative "../lib/initializer"

user = User.new
user.first_name = 'John'
user.last_name = 'Does'
user.email = 'john.does@gmail.com'
user.password = 'test123'
user.save

property = Property.new
property.name = 'test property'
property.account_id = user.account_id
property.outbound_phone_numbers = ["+12065189761"]
property.save

property = Property.new
property.name = 'test property1'
property.account_id = user.account_id
property.outbound_phone_numbers = ["+12065189761", "+12067778888"]
property.save

property_unit = PropertyUnit.new
property_unit.property_id = property.id
property_unit.account_id = user.account_id
property_unit.phone_number = "+12345678123"
property_unit.save


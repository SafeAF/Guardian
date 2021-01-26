require 'mongoid'
require 'bson'

class Person
	include Mongoid::Document
	field :name, type: String
end

Person.create(
  first_name: "Heinrich",
  last_name: "Heine"
)



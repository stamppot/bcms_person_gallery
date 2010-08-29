class PersonType < ActiveRecord::Base
  acts_as_content_block
  has_many :persons
  has_and_belongs_to_many :person_collections
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :position
  validates_uniqueness_of :position
end

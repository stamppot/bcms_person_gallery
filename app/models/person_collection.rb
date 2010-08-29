class PersonCollection < ActiveRecord::Base
  # acts_as_content_block
  
  # validates_presence_of :person_type
  validates_presence_of :name
  validates_presence_of :section_id
  
  has_and_belongs_to_many :person_types

  # def before_save
  #   self.person_types.each { |h}
end
class PersonType < ActiveRecord::Base
  after_save :change_filename # important must be above acts_as
  
  acts_as_content_block :belongs_to_attachment => true
  has_many :persons
  # belongs_to :section  # remove, check how file_path is created
  has_and_belongs_to_many :person_collections
  
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :position
  validates_uniqueness_of :position

  def change_filename
    name = "persontype-#{self.item_number}" + File.extname(self.attachment.file_path)
    path = "/persons/"
    self.attachment.name = name
    self.attachment.file_path = path + name
    self.attachment.send(:update_without_callbacks)
    self.attachment.versions.last.name = name
    self.attachment.versions.last.file_path = path + name
    self.attachment.versions.last.send(:update_without_callbacks)
  end
end

class Person < ActiveRecord::Base
  # after_save :change_filename # important must be above acts_as
  
  acts_as_content_block
  validates_presence_of :name
  validates_presence_of :summary_description
  validates_presence_of :description
  validates_each :person_type do |record, attr, value|
    if record.person_type
      record.errors.add attr, 'must be published' unless record.person_type.published?
    else
      record.errors.add attr, 'must be specified'
    end
  end
  belongs_to :person_type
  has_many :person_photos

  named_scope :published, :conditions => {:published => true}
  named_scope :of_person_type, lambda { |id| { :conditions => ['person_type_id = ?', id] } }

  def self.columns_for_index
    [ {:label => "Navn", :method => :person_name, :order => :person_type_order } ,
      {:label => "Rækkefølge", :method => :position }
    ]
  end

  # def self.default_order
  #   self.position
  # end

  def person_name
    self.name
  end
  
  def person_type_order
    self.person_type.position
  end
  
  # def change_filename
  #   name = Person.prefix + self.order.to_s
  #   filename = name + File.extname(self.attachment.file_path)
  #   
  #   path = "/persons/#{self.person_type.order}/"
  #   self.attachment.name = filename
  #   self.attachment.file_path = path + filename
  #   self.attachment.send(:update_without_callbacks)
  #   self.attachment.versions.last.name = filename
  #   self.attachment.versions.last.file_path = path + filename
  #   self.attachment.versions.last.send(:update_without_callbacks)
  # end
  
  # def self.prefix
  #   "person-"
  # end

end

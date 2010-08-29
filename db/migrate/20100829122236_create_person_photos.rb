class CreatePersonPhotos < ActiveRecord::Migration
  def self.up
    create_versioned_table :person_photos do |t|
      t.belongs_to :attachment
      t.integer :attachment_version
      t.belongs_to :person
    end

    # Do not create the menu because Person Photos are handeled by the person form
    #ContentType.create!(:name => "PersonPhoto", :group_name => "PersonPhoto")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'PersonPhoto'])
    CategoryType.all(:conditions => ['name = ?', 'Person Photo']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :person_photo_versions
    drop_table :person_photos
  end
end

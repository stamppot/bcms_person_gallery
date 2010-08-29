class CreatePersonCollections < ActiveRecord::Migration
  def self.up
    create_table :person_collections do |t|
      t.string :name 
      t.string :danish_name 
      t.text :description, :size => (64.kilobytes + 1)
      t.belongs_to :section
    end
    create_table :person_collections_person_types, :id => false do |t|
      t.integer :person_collection_id
      t.integer :person_type_id
    end

    if !ContentType.exists?(:name => "PersonCollection")
      ContentType.create!(:name => "PersonCollection", :group_name => "Personale")
    end
  end

  def self.down
    drop_table :person_collections_person_types

    ContentType.delete_all(['name = ?', 'PersonCollection'])
    CategoryType.all(:conditions => ['name = ?', 'Person Collection']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    # drop_table :person_type_versions
    drop_table :person_collections
  end
end
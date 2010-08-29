class CreatePersonTypes < ActiveRecord::Migration
  def self.up
    create_versioned_table :person_types do |t|
      t.string :name 
      t.string :order
      t.text :description, :size => (64.kilobytes + 1)
      # t.belongs_to :section
      # t.belongs_to :attachment
      # t.integer :attachment_version
    end

    if !ContentType.exists?(:name => "PersonType")
      ContentType.create!(:name => "PersonType", :group_name => "Persons")
    end
  end

  def self.down
    ContentType.delete_all(['name = ?', 'PersonType'])
    CategoryType.all(:conditions => ['name = ?', 'Person Type']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :person_type_versions
    drop_table :person_types
  end
end

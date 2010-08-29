class CreatePersons < ActiveRecord::Migration
  def self.up
    create_versioned_table :persons do |t|
      t.belongs_to :person_type
      t.string :name
      t.string :summary_description
      t.text :description, :size => (64.kilobytes + 1)
      t.integer :order
    end

    if !ContentType.exists?(:name => "Person")
      ContentType.create!(:name => "Person", :group_name => "Personale")
    end
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Person'])
    CategoryType.all(:conditions => ['name = ?', 'Person']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :person_versions
    drop_table :persons
  end
end

class Cms::PersonsController < Cms::ContentBlockController
  def create
    # increment item number
    person_type_id = params[:person][:person_type_id]
    max_item = Person.maximum(:item_number, :conditions => {:person_type_id => person_type_id}) || 0
    params[:person][:item_number] = "#{max_item + 1}"
    
    person_type = PersonType.find(person_type_id)
    super
  end

  def create
    files = fix_params params
    super
    rename_attachments files, @block
  end

  def update
    fix_price_params
    files = fix_params params
    super
    rename_attachments files, @block
  end

  private
  
  def fix_params params
    # Remember the temp files
    result = { :photo_attachment_file => params[:product][:person_photo],
      :photo_mini_attachment_file => params[:product][:person_photo_mini],
      :photo_misc_attachment_file => params[:product][:person_photo_misc] }

    # Delete the things that confuse the normal product creation (since BrowserCMS does not handle multiple attachments properly)
    params[:product].delete :person_photo
    params[:product].delete :person_photo_mini
    params[:product].delete :person_photo_misc
    params.delete :temp

    result
  end

  def rename_attachments files, block
    # Forcilby specify what to save the filename as (since passing :attachment_file_path => '/attachments/another_filename' to ProductPhoto.new seems to be ignored)
    files[:photo_attachment_file].instance_variable_set :@original_filename, 'person_photo_' + block.id.to_s + rand(10000).to_s + '.jpg'
    files[:photo_mini_attachment_file].instance_variable_set :@original_filename, 'person_photo_mini_' + block.id.to_s + rand(10000).to_s + '.jpg'
    files[:photo_misc_attachment_file].instance_variable_set :@original_filename, 'person_photo_misc_' + block.id.to_s + rand(10000).to_s + '.jpg'

    # FIXME: Currently just destroying the old photos and adding new ones
    # This breaks the versioning but allows updating but not reverting
    # I couldn't get update_attributes to work
    # It means that if you only change two of the photos it will delete the other
    # Will just make all photos manditory to fix this for now
    block.person_photos[0].destroy if block.person_photos[0]
    block.person_photos[1].destroy if block.person_photos[1]
    block.person_photos[2].destroy if block.person_photos[2]

    # Discarding original names because we can only get the last attachment
    # TODO: see if we can set the name from the attached file so the system can fix any naming conflicts automatically
    photo_large = ProductPhoto.new :name => 'photo_for_product_' + block.id.to_s + '.jpg', :attachment_file => files[:photo_attachment_file], :published => true
    photo_mini = ProductPhoto.new :name => 'photo_for_product_' + block.id.to_s + '_mini.jpg', :attachment_file => files[:photo_mini_attachment_file], :published => true
    photo_misc = ProductPhoto.new :name => 'photo_for_product_' + block.id.to_s + '_misc.jpg', :attachment_file => files[:photo_misc_attachment_file], :published => true

    photo_large.product = block
    photo_large.save
    photo_large.publish!
    photo_mini.product = block
    photo_mini.save
    photo_mini.publish!
    photo_misc.product = block
    photo_misc.save
    photo_misc.publish!
  end
end
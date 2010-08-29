namespace :db do
  namespace :seed do
    desc "Create pages and portlets required by the persons module."
    task :persons => :environment do
      class LoadPersonsSeedData
        extend Cms::DataLoader

        # Set up the sections and pages
        create_section(:persons, :name => "Persons", :parent => Section.find_by_path("/"), :path => "/persons")
        create_section(:administration, :name => "Administration", :parent => sections(:persons), :path => "/persons/administration", :hidden => true)
        Group.all.each{|g| g.sections = Section.all }
        # Remove the guest user from the persons administration
        sections(:administration).groups.delete Group.find_by_code('guest')
        sections(:administration).save

        # Use the home page template if it exists otherwise use default
        template_file_name = File.exists?('app/views/layouts/templates/home_page.html.erb') ? 'home_page.html.erb' : 'default.html.erb'

        # Public section
        create_page(:overview, :name => "Overview", :path => "/persons", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => false, :cacheable => true)
        create_page(:product_process, :name => "Person Process", :path => "/persons/product-process", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => false, :cacheable => true)
        create_page(:producers, :name => "Producers", :path => "/persons/producers", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => false, :cacheable => true)
        create_page(:persons, :name => "Persons", :path => "/persons/persons", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => false, :cacheable => true)
        create_page(:product, :name => "Person", :path => "/persons/product", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => true, :cacheable => true)
        create_page(:items_for_sale, :name => "Items for Sale", :path => "/persons/items-for-sale", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => false, :cacheable => true)
        create_page(:donate, :name => "Donate", :path => "/persons/donate", :section => sections(:persons), :template_file_name => template_file_name, :publish_on_save => true, :hidden => false, :cacheable => true)

        # Administration section
        create_page(:orders, :name => "Orders", :path => "/persons/administration/orders", :section => sections(:administration), :template_file_name => template_file_name, :publish_on_save => true, :hidden => true, :cacheable => true)

        # Set up some portlets
        set_up_portlet "recent_persons_portlet", 'app/views/portlets/recent_persons/render.html.erb',
          { "name" => "What's New?", "connect_to_page_id" => Page.find_by_path('/persons/persons').id, :limit => 10 }

        set_up_portlet "cart_portlet", 'app/views/portlets/cart/render.html.erb',
          { "name" => "Cart", "connect_to_page_id" => Page.find_by_path('/persons/persons').id }

        set_up_portlet "orders_portlet", 'app/views/portlets/orders/render.html.erb',
          { "name" => "Orders", "connect_to_page_id" => Page.find_by_path('/persons/administration/orders').id, :results_per_page => 50 }

        set_up_portlet "browse_persons_portlet", 'app/views/portlets/browse_persons/render.html.erb',
          { "name" => "Browse Persons", "connect_to_page_id" => Page.find_by_path('/persons/items-for-sale').id, :results_per_page => 20 }

        set_up_portlet "product_details_portlet", 'app/views/portlets/product_details/render.html.erb',
          { "name" => "Person Details", "connect_to_page_id" => Page.find_by_path('/persons/product').id }
      end
    end

    desc "Add some sample data to the database."
      task :sampledata => :environment do
        class LoadPersonsSampleData
          # Make sure the relevant pages exist
          Rake::Task['db:seed:persons'].invoke

          Producer.create(:name => 'Joe', :last_name => 'Bloggs', :description => 'An awesome producer.').publish!
          PersonType.create(:name => 'Rug', :danish_name => 'foo', :user_id => 0, :description => 'You can stand on it').publish!
          WoolType.create(:name => 'Sheep', :description => 'Some pretty common wool').publish!
          counter = 1
          w = Person.create(:item_number => '001', :producer_id => Producer.find_by_name('Joe', :first).id, :person_type_id => PersonType.find_by_name('Rug', :first).id,
            :wool_type_id => WoolType.find_by_name('Sheep', :first).id, :purchase_price_usd => 123.43, :purchase_price_bob => 32.21,
            :selling_price => 231.21, :summary_description => 'Summary goes here.', :description => 'Description of product here.', :published => true)
          set_up_person_photos w, counter ; counter += 3
          w = Person.create(:item_number => '002', :producer_id => Producer.find_by_name('Joe', :first).id, :person_type_id => PersonType.find_by_name('Rug', :first).id,
            :wool_type_id => WoolType.find_by_name('Sheep', :first).id, :purchase_price_usd => 123.43, :purchase_price_bob => 32.21,
            :selling_price => 40.12, :summary_description => 'Summary goes here.', :description => 'Description of product here.', :published => true)
          set_up_person_photos w, counter ; counter += 3
          w = Person.create(:item_number => '003', :producer_id => Producer.find_by_name('Joe', :first).id, :person_type_id => PersonType.find_by_name('Rug', :first).id,
            :wool_type_id => WoolType.find_by_name('Sheep', :first).id, :purchase_price_usd => 123.43, :purchase_price_bob => 32.21,
            :selling_price => 432, :summary_description => 'Summary goes here.', :description => 'Description of product here.', :published => true)
          set_up_person_photos w, counter ; counter += 3
          w = Person.create(:item_number => '004', :producer_id => Producer.find_by_name('Joe', :first).id, :person_type_id => PersonType.find_by_name('Rug', :first).id,
            :wool_type_id => WoolType.find_by_name('Sheep', :first).id, :purchase_price_usd => 123.43, :purchase_price_bob => 32.21,
            :selling_price => 3, :summary_description => 'Summary goes here.', :description => 'Description of product here.', :published => true)
          set_up_person_photos w, counter ; counter += 3
          w = Person.create(:item_number => '005', :producer_id => Producer.find_by_name('Joe', :first).id, :person_type_id => PersonType.find_by_name('Rug', :first).id,
            :wool_type_id => WoolType.find_by_name('Sheep', :first).id, :purchase_price_usd => 123.43, :purchase_price_bob => 32.21,
            :selling_price => 95, :summary_description => 'Summary goes here.', :description => 'Description of product here.', :published => true)
          set_up_person_photos w, counter ; counter += 3
          w = Person.create(:item_number => '006', :producer_id => Producer.find_by_name('Joe', :first).id, :person_type_id => PersonType.find_by_name('Rug', :first).id,
            :wool_type_id => WoolType.find_by_name('Sheep', :first).id, :purchase_price_usd => 123.43, :purchase_price_bob => 32.21,
            :selling_price => 1, :summary_description => 'I should have an image.', :description => 'Description of product here.', :published => true)
          set_up_person_photos w, counter ; counter += 3
          end
      end
  end
  private
  def set_up_person_photos product, start_index
    count = start_index
    set_up_person_photo product, 'persons_test_photos/' + count.to_s + '.jpg', 'person_photo_front_' + product.id.to_s + '.jpg', 'photo_for_product_' + product.id.to_s + '_front.jpg'
    count += 1
    set_up_person_photo product, 'persons_test_photos/' + count.to_s + '.jpg', 'person_photo_back_' + product.id.to_s + '.jpg', 'photo_for_product_' + product.id.to_s + '_back.jpg'
    count += 1
    set_up_person_photo product, 'persons_test_photos/' + count.to_s + '.jpg', 'person_photo_misc_' + product.id.to_s + '.jpg', 'photo_for_product_' + product.id.to_s + '_misc.jpg'
  end

  def set_up_person_photo product, file_path, original_name, person_photo_name
    require 'test_help'
    tempfile = ActionController::UploadedTempfile.new(original_name)
    realfile = File.open file_path
    open(tempfile.path, 'w') {|f| f << realfile.read}
    tempfile.original_path = original_name
    tempfile.content_type = 'image/jpeg'

    photo_front = PersonPhoto.new :name => person_photo_name, :attachment_file => tempfile, :published => true
    photo_front.product = product
    photo_front.save
    photo_front.publish!
  end

  def set_up_portlet portlet_name, template_path, portlet_arguments
    template_file = RAILS_ROOT + '/' + template_path
    template = ''
    # If the template file does not exist we are running out of the gem so grab the template file from there
    # TODO: Implement this in a more robust way
    template_file = '/usr/lib/ruby/gems/1.8/gems/bcms_persons-1.0.0/' + template_path unless File.exists? template_file
    File.open(template_file, "r") { |f| template = f.read }

    portlet_arguments[:template] = template
    portlet_arguments[:handler] = "erb" unless portlet_arguments[:handler]
    portlet_arguments[:connect_to_container] = "main" unless portlet_arguments[:connect_to_container]
    portlet = portlet_name.classify.constantize.new(portlet_arguments)
    portlet.save
  end
end

module Cms::Routes
  def routes_for_bcms_persons
    # add_product_to_cart "/store/add_to_cart", :controller => '/store', :action => 'add_to_cart', :conditions => {:method => :put}
    # add_product_to_cart "/store/remove_from_cart", :controller => '/store', :action => 'remove_from_cart', :conditions => {:method => :put}
    # resources :orders, :new => { :paypal_express => :get, :charge => :post, :ship => :post }
    get_random_person '/random_persons/show', :controller => 'cms/random_persons', :action => 'show'

    namespace(:cms) do |cms|
      cms.content_blocks :persons
      cms.content_blocks :person_types
      cms.content_blocks :person_collections
      # cms.content_blocks :random_persons
    end
  end
end

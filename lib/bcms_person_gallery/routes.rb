module Cms::Routes
  def routes_for_bcms_persons
    # get_random_person '/random_persons/show', :controller => 'cms/random_persons', :action => 'show'

    namespace(:cms) do |cms|
      cms.content_blocks :persons
      cms.content_blocks :person_types
      cms.content_blocks :person_collections
    end
  end
end

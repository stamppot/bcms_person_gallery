module PersonCollectionsHelper
  def person_collection_contains_person_type?(person_type)
    if @person_collection && !@person_collection.person_types.nil? # no sense in testing new users that have no languages
      @person_collection.person_types.include?(person_type)
    else
      false
    end
  end
end
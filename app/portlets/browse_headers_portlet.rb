class BrowsePersonsPortlet < Portlet
  def render
    @person_types = PersonType.find(:all)

    if params[:type]
      # We should search by product type
      @persons_to_browse = Person.find(:all, :conditions => ["published = ? AND person_type_id = ?", true, params[:type]])
      @search_results_summary = 'Found ' + @persons_to_browse.size.to_s + ' persons of type ' + PersonType.find(params[:type]).name
    end
  end
end
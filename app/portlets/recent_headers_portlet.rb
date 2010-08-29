class RecentPersonsPortlet < Portlet

  def render
    @persons = Person.all(:order => "created_at desc", :limit => self.limit)
  end
    
end
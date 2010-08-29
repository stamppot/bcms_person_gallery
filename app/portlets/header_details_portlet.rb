class PersonDetailsPortlet < Portlet

  def render
    @person = Person.find(params[:id])
  end

end
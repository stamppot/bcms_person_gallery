class Cms::PersonCollectionsController < Cms::ContentBlockController

  def new
    @person_collection = PersonCollection.new
    @person_types = PersonType.not_deleted(:order => "name")#.map{|e| [e.name, e.id]}
    super
  end
  
  def create
    @section = Section.find params[:person_collection][:section_id]
    @person_types = PersonType.find(params[:person_collection][:person_type_ids])
    @person_collection = PersonCollection.new(params[:person_collection])
    @person_collection.person_types = @person_types
    @person_collection.person_types.each &:save
    @person_collection.save
    # super
    redirect_to :action => :index
  end
  
  def edit
    @person_collection = PersonCollection.find params[:id]
    @person_types = PersonType.not_deleted(:order => "name")#.map{|e| [e.name, e.id]}
    super
  end
  
  def update
    @person_collection = PersonCollection.find params[:id]
    params[:person_collection][:person_type_ids] ||= []

    @section = Section.find params[:person_collection][:section_id]
    @person_types = PersonType.find(params[:person_collection][:person_type_ids])

    if @person_collection.update_attributes params[:person_collection]
      redirect_to :action => :index and return
    else
      flash.now[:error] = @person_collection.errors
      setup_form_values
      respond_to do |format|
        format.html { render :action => :edit} and return
      end
    end
    # super
  end
end
class RandomPersonController < ActionController::Base

  def show
    params.delete "_"
    page = Page.find params[:id]
    person = RandomPerson.get(page, true)
    debugger
    render :text => person
  end

end
class Cms::PersonTypesController < Cms::ContentBlockController

  def create
    max_item = (PersonType.maximum(:position) || 0).to_s
    params[:person_type][:position] = (max_item + 1).to_s
    super
  end

  # def update
  #   super
  # end

end
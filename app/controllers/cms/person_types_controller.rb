class Cms::PersonTypesController < Cms::ContentBlockController

  def create
    max_item = (PersonType.maximum(:position) || 0)
    params[:person_type][:position] = (max_item.to_i + 1)
    super
  end

  # def update
  #   super
  # end

end
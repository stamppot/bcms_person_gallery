class Cms::PersonTypesController < Cms::ContentBlockController

  def create
    max_item = (PersonType.maximum(:order) || "0").to_i
    params[:person_type][:position] = (max_item + 1).to_s
    super
  end

  # def update
  #   super
  # end

end
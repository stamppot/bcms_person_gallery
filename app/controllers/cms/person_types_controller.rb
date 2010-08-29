class Cms::PersonTypesController < Cms::ContentBlockController

  def create
    max_item = (PersonType.maximum(:item_number) || "0").to_i
    params[:person_type][:item_number] = (max_item + 1).to_s
    super
  end

  # def update
  #   super
  # end

end
class RequestsController < ApplicationController
  def create
    @cats_list = CatItem
    if cat_categories = params[:cat_category]
      @cats_list = @cats_list.where('cat_category_id in (?)', cat_categories)
    end
    @cats_list = @cats_list.order(:price)
    render :result
    # redirect_to @cats_list_request_path(cats_list: @cats_list, cat_type: params[:cats_type], location: params[:user_location])
  end

  def result
    @cats_list = params[:cats_list].select { |list| list['location'] == params[:location] && list['name'] == params[:cat_type] }
  end
end

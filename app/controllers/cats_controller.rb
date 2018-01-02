class CatsController < ApplicationController
  def index
    @cats_list = CatItem.filter(params_filter(:city), params_filter(:cat_category))

    @best_price = @cats_list.first&.price

    current_page = params[:page] || 1
    @cats_list = @cats_list.paginate(page: current_page, per_page: 5)
  end

  private

  def params_filter(key)
    if (values = params[key]) && !values.include?('')
      return values
    end
  end
end

class CatsController < ApplicationController
  def index
    @best_price, @cats_list = CatItem.filter_items(params_filter(:city),
                                                   params_filter(:cat_category))

    current_page = params[:page] || 1
    @cats_list = @cats_list.paginate(page: current_page, per_page: 5)
  end

  private

  def params_filter(key)
    values = params[key]
    values if values && !values.include?('')
  end
end

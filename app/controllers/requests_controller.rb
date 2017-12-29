class RequestsController < ApplicationController
  def create
    result = []
    result += CatsApi::AmazonawsJSON.new.perform
    result += CatsApi::AmazonawsXML.new.perform
    redirect_to result_request_path(cats_list: result, cat_type: params[:cats_type], location: params[:user_location])
  end

  def result
    @cats_list = params[:cats_list].select { |list| list['location'] == params[:location] && list['name'] == params[:cat_type]}
  end
end

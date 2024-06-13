class OrdersController < ApplicationController
  def index
    @orders = Order.order(:created_at).page(params[:page])
  end
end
class Admin::DashboardController < ApplicationController
  def show
    @categories_available = Category.count
    @products_available = Product.count
  end
end

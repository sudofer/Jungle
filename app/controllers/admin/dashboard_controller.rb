class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASS']
  def show
    @total_products = Product.count()
    @total_categories = Category.count()
  end
end

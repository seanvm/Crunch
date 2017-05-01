class HomeController < ApplicationController
  def show
    render :layout => 'external_pages'
  end
end
class HomeController < ApplicationController
  def index
    render :index, locals: {
      makes: MakeService.new.find_all_makes
    }
  end
end

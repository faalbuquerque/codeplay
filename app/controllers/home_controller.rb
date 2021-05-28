class HomeController < ApplicationController
  def index
  end

  def search
    @courses = Course.where('name like ? OR description like?',
                            "%#{params[:query]}%",
                            "%#{params[:query]}%")
  end
end

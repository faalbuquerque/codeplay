class HomeController < ApplicationController
  def index
    @courses = Course.where("enrollment_deadline >= ?", Date.today)
  end

  def search
    @courses = Course.where('name like ? OR description like?',
                            "%#{params[:query]}%",
                            "%#{params[:query]}%")
  end
end

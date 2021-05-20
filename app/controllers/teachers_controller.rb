class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find_by(id: params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    return redirect_to @teacher if @teacher.save

    render :new
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :bio, :profile_picture)
  end
end
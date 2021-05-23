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
    msg = t('.success')
    return redirect_to @teacher, notice: msg if @teacher.save

    render :new
  end

  def edit
    @teacher = Teacher.find_by(id: params[:id])
  end

  def update
    @teacher = Teacher.find_by(id: params[:id])
    msg = t('.success')
    return redirect_to @teacher if @teacher.update(teacher_params)

    render :edit
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :bio, :profile_picture)
  end
end
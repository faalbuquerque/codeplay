class Api::V1::CoursesController < ActionController::API

  def index
    @courses = Course.all
    render json: @courses.as_json(except: [:created_at, :updated_at, :teacher_id],
                                  include: :teacher)
  end

  def show
    @course = Course.find_by!(code: params[:code])
    render json: @course
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  def create
    @course = Course.new(course_params)
    @course.save!

    render json: @course, status: :created
  end

  private
  def course_params
    params.require(:course).permit(:teacher_id, :name, :description, :code, :price,
                                   :enrollment_deadline)
  end
end

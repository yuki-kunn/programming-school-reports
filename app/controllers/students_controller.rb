class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :load_tags, only: %i[new edit create update]

  def index
    @students = Student.all.order(:name)
  end

  def show
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: "生徒を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: "生徒情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: "生徒を削除しました"
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :admission_date, :enrollment_status, :memo, :tag_id)
  end

  def load_tags
    @tags = Tag.order(:name)
  end
end

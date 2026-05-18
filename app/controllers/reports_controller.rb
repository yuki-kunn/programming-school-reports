class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]
  before_action :load_students, only: %i[new edit create update]

  def index
    @tags = Tag.order(:name)
    @current_tag = params[:tag_id].present? ? Tag.find_by(id: params[:tag_id]) : nil
    @reports = Report.includes(:user, :student).order(learning_date: :desc)
    if @current_tag
      @reports = @reports.joins(:student).where(students: { tag_id: @current_tag.id })
    end
    @reports = @reports.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @report = current_user.reports.build(learning_date: Date.current)
  end

  def edit
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to @report, notice: "日報を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: "日報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: "日報を削除しました"
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def ensure_correct_user
    unless @report.user == current_user || admin_or_above?
      flash[:alert] = "権限がありません"
      redirect_to reports_path
    end
  end

  def report_params
    params.require(:report).permit(:learning_date, :content, :student_id)
  end

  def load_students
    @students = Student.active_students.order(:name)
  end
end

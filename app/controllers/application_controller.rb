class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :check_force_password_change
  helper_method :current_user, :logged_in?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to new_session_path
    end
  end

  def check_force_password_change
    return unless logged_in?
    return unless current_user.force_password_change?
    return if controller_name == 'passwords' || (controller_name == 'sessions' && action_name == 'destroy')

    flash[:alert] = "初回ログインのため、パスワードを変更してください"
    redirect_to edit_password_path
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end

  def record_not_found
    flash[:alert] = "お探しのページが見つかりません"
    redirect_to root_path
  end
end

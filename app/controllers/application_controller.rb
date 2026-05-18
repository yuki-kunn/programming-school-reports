class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :check_force_password_change
  helper_method :current_user, :logged_in?, :admin_or_above?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id  = cookies.encrypted[:remember_user_id]) &&
          (token    = cookies.encrypted[:remember_token])
      user = User.find_by(id: user_id)
      if user&.authenticated_by_token?(token)
        reset_session
        session[:user_id] = user.id
        @current_user = user
      end
    end
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
    unless admin_or_above?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end

  def admin_or_above?
    current_user&.admin? || current_user&.superadmin?
  end

  def record_not_found
    flash[:alert] = "お探しのページが見つかりません"
    redirect_to root_path
  end
end

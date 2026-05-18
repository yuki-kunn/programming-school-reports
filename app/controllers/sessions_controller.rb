class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session                    # セッション固定攻撃対策
      session[:user_id] = user.id

      if params[:session][:remember_me] == '1'
        token = user.remember
        cookies.permanent.encrypted[:remember_user_id] = { value: user.id,  httponly: true, same_site: :lax }
        cookies.permanent.encrypted[:remember_token]   = { value: token,    httponly: true, same_site: :lax }
      else
        user.forget
        cookies.delete(:remember_user_id)
        cookies.delete(:remember_token)
      end

      flash[:notice] = "ログインしました"
      redirect_to root_path
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    current_user&.forget
    cookies.delete(:remember_user_id)
    cookies.delete(:remember_token)
    reset_session                      # セッション全体を無効化
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end

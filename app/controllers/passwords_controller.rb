class PasswordsController < ApplicationController
  def edit; end

  def update
    if !current_user.authenticate(params.dig(:password_change, :current_password))
      flash.now[:alert] = "現在のパスワードが正しくありません"
      return render :edit, status: :unprocessable_entity
    end

    if current_user.update(new_password_params)
      current_user.update_column(:force_password_change, false)
      flash[:notice] = "パスワードを変更しました"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def new_password_params
    params.require(:password_change).permit(:password, :password_confirmation)
  end
end

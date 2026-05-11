class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.order(role: :desc, name: :asc).page(params[:page]).per(20)
  end

  def show
    @reports = @user.reports.includes(:student).order(created_at: :desc).limit(20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    @user.force_password_change = true
    if @user.save
      flash[:notice] = "#{@user.name} のアカウントを作成しました"
      redirect_to admin_users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user == current_user
      flash[:alert] = "自分自身の権限を変更することはできません"
      return redirect_to admin_users_path
    end

    new_role = params.dig(:user, :role)
    unless User.roles.key?(new_role)
      flash[:alert] = "無効な権限値です"
      return redirect_to admin_user_path(@user)
    end

    if new_role == "general" && @user.admin? && User.where(role: :admin).count == 1
      flash[:alert] = "最後の管理者の権限は取り消せません"
      return redirect_to admin_user_path(@user)
    end

    if @user.update(role_params)
      flash[:notice] = "#{@user.name} の権限を更新しました"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path
  end

  def destroy
    if @user == current_user
      flash[:alert] = "自分自身のアカウントは削除できません"
      return redirect_to admin_users_path
    end

    if @user.admin? && User.where(role: :admin).count == 1
      flash[:alert] = "最後の管理者は削除できません"
      return redirect_to admin_user_path(@user)
    end

    user_name = @user.name
    @user.destroy
    flash[:notice] = "#{user_name} のアカウントを削除しました"
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to admin_users_path
    end
  end

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def role_params
    params.require(:user).permit(:role)
  end
end

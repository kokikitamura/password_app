class PasswordsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @word = params[:word]
    @all_passwords = Password.where(user_id: current_user.id)
    if @word.nil?
      if params[:sort_key] == "created_latest"
        @passwords = Password.created_latest.where(user_id: current_user.id).page(params[:page]).per(50)
      elsif params[:sort_key] == "created_old"
        @passwords = Password.created_old.where(user_id: current_user.id).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_latest"
        @passwords = Password.updated_latest.where(user_id: current_user.id).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_old"
        @passwords = Password.updated_old.where(user_id: current_user.id).page(params[:page]).per(50)
      else
      @passwords = Password.created_latest.where(user_id: current_user.id).page(params[:page]).per(50)
      #デフォルトは作成日が新しい順
      end
    else
      if params[:sort_key] == "created_latest"
        @passwords = Password.created_latest.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      elsif params[:sort_key] == "created_old"
        @passwords = Password.created_old.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_latest"
        @passwords = Password.updated_latest.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_old"
        @passwords = Password.updated_old.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      else
      @passwords = Password.created_latest.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      #デフォルトは作成日が新しい順
      end
    end
  end

  def show
    @password = Password.find(params[:id])
  end

  def new
    @password = Password.new
  end

  def create
    @password = current_user.passwords.build(password_params)
    if @password.save
      flash[:success] = "追加しました"
      redirect_to passwords_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @password = Password.find(params[:id])
  end

  def update
    @password = Password.find(params[:id])
    if @password.update(password_params)
      flash[:success] = "更新しました"
      redirect_to @password
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    Password.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to passwords_path, status: :see_other
  end

  private

    def password_params
      params.require(:password).permit(:title, :account, :pass, :category_id, :url, :memo)
    end

    # beforeフィルタ

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url, status: :see_other
      end
    end
end


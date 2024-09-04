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
    session[:before_show]&.clear
    session[:before_show] = request.referer
  end

  def new
    @password = Password.new
    session[:before_new] = request.referer
  end

  def create
    @password = current_user.passwords.build(password_params)
    if @password.category.nil?
      @password.category = current_user.categories.find_by(name: "未分類")
    end
    if @password.save
      flash[:success] = "追加しました"
      redirect_to session[:before_new]
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @password = Password.find(params[:id])
    session[:before_edit]&.clear
    session[:before_edit] = request.referer
  end

  def update
    @password = Password.find(params[:id])
    if @password.update(password_params)
      flash[:success] = "更新しました"
      if session[:before_show]&.match(/categories/)
        redirect_to session[:before_show]
        session[:before_show].clear
      elsif session[:before_edit]&.match(/categories/)
        redirect_to session[:before_edit]
        session[:before_edit].clear
      else
        redirect_to passwords_path
        session[:before_show].clear
        session[:before_edit].clear
      end
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


class CategoriesController < ApplicationController
  def index
    @categories = Category.where(user_id: current_user.id)
  end

  def show
    @category = Category.find(params[:id])
    @word = params[:word]
    if @word.nil?
      if params[:sort_key] == "created_latest"
        @passwords = @category.passwords.created_latest.where(user_id: current_user.id).page(params[:page]).per(50)
      elsif params[:sort_key] == "created_old"
        @passwords = @category.passwords.created_old.where(user_id: current_user.id).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_latest"
        @passwords = @category.passwords.updated_latest.where(user_id: current_user.id).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_old"
        @passwords = @category.passwords.updated_old.where(user_id: current_user.id).page(params[:page]).per(50)
      else
      @passwords = @category.passwords.created_latest.where(user_id: current_user.id).page(params[:page]).per(50)
      end
    else
      if params[:sort_key] == "created_latest"
        @passwords = @category.passwords.created_latest.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      elsif params[:sort_key] == "created_old"
        @passwords = @category.passwords.created_old.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_latest"
        @passwords = @category.passwords.updated_latest.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      elsif params[:sort_key] == "updated_old"
        @passwords = @category.passwords.updated_old.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      else
      @passwords = @category.passwords.created_latest.where(user_id: current_user.id).search_for(@word).page(params[:page]).per(50)
      end
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:success] = "追加しました"
      redirect_to categories_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "更新しました"
      redirect_to categories_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.name == "未分類"
      redirect_to categories_path, status: :see_other
    else
      uncategorized_category = current_user.categories.find_by(name: "未分類")
      @category.passwords.update_all(category_id: uncategorized_category.id)
      @category.destroy
      flash[:notice] = "削除しました"
      redirect_to categories_path, status: :see_other
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
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

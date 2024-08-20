class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to edit_user_path(user) #リダイレクト先はパスワードのindexにする予定。
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが正しくありません。'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end

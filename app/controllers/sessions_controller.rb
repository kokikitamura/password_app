class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      log_in user
      flash[:success] = "ログインしました"
      redirect_to forwarding_url || passwords_path
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません。"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました"
    redirect_to login_url, status: :see_other
  end
end

class PasswordsController < ApplicationController
  def index
    @passwords = Password.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

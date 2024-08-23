class SearchesController < ApplicationController
  def search
    @word = params[:word]
    @passwords_serached = Password.created_latest.where(user_id: current_user.id).search_for(@word).page(params[:page])
  end
end

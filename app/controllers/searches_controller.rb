class SearchesController < ApplicationController
  def index
    if params[:query].present?
      @users = User.where("username LIKE ?", "%#{params[:query]}%")
    else
      @users = []
    end
  end
end

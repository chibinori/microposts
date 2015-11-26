class FavoritepostRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    #binding.pry
    
    @micropost = Micropost.find(params[:micropost_id])
    current_user.regist_favoritepost(@micropost)
  end

  def destroy
    #binding.pry
    
    @micropost = current_user.favoritepost_relationships.find(params[:id]).micropost
    current_user.release_favoritepost(@micropost)
  end
end

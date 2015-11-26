class RepostRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    #binding.pry
    
    # リツイートするツイート
    @base_post = Micropost.find(params[:base_post_id])
    
    # リツイートを作成
    newpost = Micropost.new
    newpost.user_id = current_user.id
    # 何も入ってないとバリデーションでエラーになるため適当な文字を入れる
    newpost.content ="#"
    
    if !newpost.save
      flash[:danger] = "Fail to repost!"
      redirect_to request.referrer || root_url
    end
    
    #binding.pry
    # 作成したリツイートと引用元のツイートの関連を作成する
    @repost_relationship = RepostRelationship.new
    @repost_relationship.reposting_id = newpost.id
    @repost_relationship.reposted_id = @base_post.id
    
    if !@repost_relationship.save
      flash[:danger] = "Fail to repost!"
      return redirect_to request.referrer || root_url
    end
    
    # javascriptで置き換える場所を示すidを取得
    # Ajaxでリツイート処理は行わない
    # @displayed_post = Micropost.find(params[:displayed_post_id])
    flash[:success] = "Repost created"
    redirect_to request.referrer || root_url
  end

  def destroy
    #binding.pry
    
    repost_relationship = RepostRelationship.find(params[:id])
    repost_relationship.destroy if repost_relationship
    
    @base_post = Micropost.find(params[:base_post_id])
    
    #javascriptで置き換える場所を示すidを取得
    # Ajaxでリツイート処理は行わないのでコメントアウト
    # @displayed_post = Micropost.find(params[:displayed_post_id])

    flash[:success] = "Repost deleted"
    redirect_to request.referrer || root_url
  end
end

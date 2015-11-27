class RepostRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    #binding.pry
    
    # リツイートするツイート
    @base_post = Micropost.find(params[:base_post_id])
    
    
    ActiveRecord::Base.transaction do
      
      # リツイートを作成
      newpost = Micropost.new
      newpost.user_id = current_user.id
      # 何も入ってないとバリデーションでエラーになるため適当な文字を入れる
      newpost.content ="#"
      
      newpost.save!
      
      # 作成したリツイートと引用元のツイートの関連を作成する
      @repost_relationship = RepostRelationship.new
      @repost_relationship.reposting_id = newpost.id
      @repost_relationship.reposted_id = @base_post.id
      
      @repost_relationship.save!
    end
    
      # javascriptで置き換える場所を示すidを取得
      # Ajaxでリツイート処理は行わない
      # @displayed_post = Micropost.find(params[:displayed_post_id])
      flash[:success] = t('repost_relationships.create_success')
      # request.referrerではページネーションが絡んでくる。
      # リツイートした結果をみたいので最新のツイートが表示されるトップページに遷移する
      redirect_to root_url
    
    rescue => e
      flash[:danger] = "Fail to repost! message:" + e.message
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

    flash[:success] = t('repost_relationships.destroy_success')
    redirect_to request.referrer || root_url
  end
end

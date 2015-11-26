class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :biography, length: { maximum: 100 }
  validates :location, length: { maximum: 100 }
  
  has_secure_password
  
  has_many :microposts
  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  #
  # お気に入り機能で使用する
  #
  has_many :favoritepost_relationships , class_name:  "FavoritepostRelationship",
                                        foreign_key: "user_id",
                                        dependent: :destroy
  has_many :favoriteposts, through: :favoritepost_relationships, source: :micropost
  # あるツイートをお気に入りにする
  def regist_favoritepost(micropost)
    favoritepost_relationships.find_or_create_by(micropost_id: micropost.id)
  end
  
  # あるツイートをお気に入りから外す
  def release_favoritepost(micropost)
    favoritepost_relationship = favoritepost_relationships.find_by(micropost_id: micropost.id)
    favoritepost_relationship.destroy if favoritepost_relationship
  end
  
  # あるツイートをお気に入りにしているかどうか？
  def is_favoritepost?(micropost)
    favoriteposts.include?(micropost)
  end
  
  #
  # リツイート機能で使用する
  #
  # このユーザが指定されたツイートをリツイートした時の関連を取得する
  def get_repost_relationship(micropost)
    if !micropost.reposted_posts.any?
      return nil
    end
    
    posting = micropost.reposted_posts.find_by(user_id: self.id)
    
    if posting.blank?
      return nil
    end
    
    return posting.reposting_relationship
  end
  

end

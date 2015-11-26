class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  mount_uploader :postimage, PostImageUploader
  
  has_many :favoritepost_relationships , class_name:  "FavoritepostRelationship",
                                          foreign_key: "micropost_id",
                                          dependent: :destroy
  
  has_one :reposting_relationship, class_name:  "RepostRelationship",
                                     foreign_key: "reposting_id",
                                     dependent:   :destroy
  has_one :reposting_post, through: :reposting_relationship, source: :reposted
  
  has_many :reposted_relationships, class_name:  "RepostRelationship",
                                    foreign_key: "reposted_id",
                                    dependent:   :destroy
  has_many :reposted_posts, through: :reposted_relationships, source: :reposting
  
end

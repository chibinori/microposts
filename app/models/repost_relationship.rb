class RepostRelationship < ActiveRecord::Base
  # リツイートの関連が削除されたらリツイートで作成されたMicropostは削除する。
  belongs_to :reposting, class_name: "Micropost", dependent: :destroy
  # リツイートの関連が削除されてもリツイート元のMicropostは削除しない。
  belongs_to :reposted, class_name: "Micropost"
end

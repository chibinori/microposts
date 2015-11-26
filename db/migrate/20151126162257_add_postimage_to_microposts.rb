class AddPostimageToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :postimage, :string
  end
end

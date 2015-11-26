class CreateRepostRelationships < ActiveRecord::Migration
  def change
    create_table :repost_relationships do |t|
      t.references :reposting, index: true
      t.references :reposted, index: true

      t.timestamps null: false

      t.index [:reposting_id, :reposted_id], unique: true
    end
  end
end

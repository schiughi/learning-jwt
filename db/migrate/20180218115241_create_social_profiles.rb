class CreateSocialProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :social_profiles do |t|
      t.references :user  , index: true , foreign_key: true
      t.string :provider  , null: false
      t.string :uid       , null: false
      t.string :token     , null: false
      t.text :description , null: false , default: ""
      t.jsonb :info       , null: false , default: "{}"
      t.jsonb :extra      , null: false , default: "{}"
      t.jsonb :credentials, null: false , default: "{}"

      t.timestamps

      t.index %i(provider uid), unique: true
    end
  end
end

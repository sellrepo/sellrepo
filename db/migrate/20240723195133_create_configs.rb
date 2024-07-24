class CreateConfigs < ActiveRecord::Migration[7.2]
  def change
    create_table :configs do |t|
      t.string :app_name
      t.string :support_url
      t.string :github_token

      t.timestamps
    end
  end
end

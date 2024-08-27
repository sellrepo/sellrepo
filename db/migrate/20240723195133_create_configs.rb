class CreateConfigs < ActiveRecord::Migration[7.2]
  def change
    create_table :configs do |t|
      t.string :store_name
      t.string :company_name
      t.string :support_url

      t.timestamps
    end
  end
end

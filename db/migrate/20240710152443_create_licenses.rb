class CreateLicenses < ActiveRecord::Migration[7.2]
  def change
    create_table :licenses do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :pay_charge
      t.belongs_to :pay_subscription
      t.string :name
      t.string :state
      t.integer :allowed_users, default: 1
      t.integer :users_count, default: 0

      t.timestamps
    end
  end
end

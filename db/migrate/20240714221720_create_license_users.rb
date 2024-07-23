class CreateLicenseUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :license_users do |t|
      t.belongs_to :license, null: false, foreign_key: true
      t.string :github_username

      t.timestamps
    end
  end
end

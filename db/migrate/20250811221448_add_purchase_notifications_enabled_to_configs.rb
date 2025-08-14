class AddPurchaseNotificationsEnabledToConfigs < ActiveRecord::Migration[8.0]
  def change
    add_column :configs, :purchase_notifications, :boolean, default: true
  end
end

class UserMailer < ApplicationMailer
  def purchase_notification_email
    @license = params[:license]

    admin_users = User.admins
    admin_emails = admin_users.map { |user| email_address_with_name(user.email, "#{user.first_name} #{user.last_name}".strip) }
    subject = "#{@license.user.first_name} purchased a #{@license.product.name} license from #{SellRepo.store_name}!"
    mail(to: admin_emails, subject: subject)
  end
end

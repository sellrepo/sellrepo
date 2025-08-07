class UserMailer < ApplicationMailer
  def purchase_notification_email
    @product = params[:product]

    admin_emails = User.admins.pluck(:email)
    subject = "New License Purchase!"
    mail(to: admin_emails, subject: subject)
  end
end

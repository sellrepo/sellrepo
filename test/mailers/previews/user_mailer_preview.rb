# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def purchase_notification_email
    UserMailer.with(product: Product.first).purchase_notification_email
  end
end

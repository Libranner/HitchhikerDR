
require 'digest/sha2'
class UserMailer < ActionMailer::Base
  default from: "hitchhikerdr@gmail.com"
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sign_up_confirmation.subject
  #
  def sign_up_confirmation(user)
    @user = user
    mail to: user.email, subject: 'Welcome aboard!'
  end

  def reservation_notice(driver)
    mail to: driver.email, subject: 'Someone new'
  end
end

class UserMailer < ApplicationMailer
  
  default_url_options[:host] = Settings.domain

  def password_reset_instructions(user)
    subject       "You Have Requested To Change Your Password"
    from          Settings.admin_email
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_url => edit_password_admin_users_url(:password_reset_token => user.password_reset_token)
  end

end

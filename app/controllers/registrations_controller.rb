class RegistrationsController < Devise::RegistrationsController

  def create
    super
    user = User.find_by(email: params[:user][:email])
    UserMailer.sign_up_confirmation(user).deliver unless user.nil?
    #redirect_to trips_path
  end

end
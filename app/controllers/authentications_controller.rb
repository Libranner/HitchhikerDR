class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    #request.env["omniauth.auth"]
    #render text: request.env["omniauth.auth"].to_yaml
    #return

    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      UserMailer.sign_up_confirmation(user).deliver if user.sign_in_count == 0
      flash.notice = "Signed in!"
      sign_in user
      redirect_to trips_path
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
    #render :text => request.env["omniauth.auth"].to_yaml
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
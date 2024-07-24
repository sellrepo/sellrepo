class Licenses::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_license

  def create
    @license_user = @license.users.create(license_user_params)
    if @license_user
      flash[:notice] = "Check your email to accept the GitHub invitation to this repository."
    else
      flash[:alert] = @license_user.errors.full_messages.first
    end

    redirect_to @license
  end

  def destroy
    @license.users.find(params[:id]).destroy
    redirect_to @license
  end

  private

  def set_license
    @license = current_user.licenses.find(params[:license_id])
  end

  def license_user_params
    params.require(:license_user).permit(:github_username)
  end
end

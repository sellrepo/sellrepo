class LicensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_license, only: [ :show, :edit, :update ]

  def index
    @licenses = current_user.licenses.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @license.update(license_params)
      redirect_to @license, notice: "License updated successfullly."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_license
    @license = current_user.licenses.find(params[:id])
  end

  def license_params
    params.require(:license).permit(:name)
  end
end

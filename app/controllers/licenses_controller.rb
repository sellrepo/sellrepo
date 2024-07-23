class LicensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_license, only: [:show]

  def index
    @licenses = current_user.licenses.order(created_at: :desc)
  end

  def show
  end

  private

  def set_license
    @license = current_user.licenses.find(params[:id])
  end
end

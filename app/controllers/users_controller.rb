class UsersController < ApplicationController
  before_action :set_user, only: [:create_order_history, :download_order_history]

  def index
    @users = User.order(:created_at).page(params[:page])
  end

  def create_order_history
    if @user
      CreateUserOrderHistoryJob.perform_later(@user.id)
      respond_to do |format|
        format.js { render inline: "alert('CSV generation started. Download will begin shortly');" }
      end
    else
      respond_to do |format|
        format.js { render inline: "error('There was some error. Please try again');" }
      end
    end
  end

  def download_order_history
    file_path = Rails.root.join("tmp/#{@user.id}_orders.csv")
    if @user && File.exist?(file_path)
      send_file file_path, filename: "#{@user.name}_orders.csv", type: 'text/csv'
    else
      render plain: "File not found", status: 404
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end

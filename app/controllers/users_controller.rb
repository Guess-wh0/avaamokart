class UsersController < ApplicationController
  before_action :set_user, only: [:create_order_history, :download_order_history]
  def index
    @users = User.order(:created_at).page(params[:page])
  end

  def create_order_history
    if @user
      # CreateUserHistoryJob.perform_later(user.id)
      print('*'*1000)
      # respond_to do |format|
      #   format.turbo_stream
      # end
      render turbo_stream: turbo_stream.update("counter", html: 'CSV generation started. Download will begin shortly')

      # render turbo_stream:
      #   turbo_stream.replace(
      #     "counter",
      #     "partial": 'users/notice',
      #     "locals": { message: 'CSV generation started. Download will begin shortly' }
      #   )
      # respond_to do |format|
      #   format.js { render inline: "alert('CSV generation started. Download will begin shortly');" }
      # end
    else
      render json: {
            success:  false,
            message:  "There was some error. Please refresh the page and try again"
          }, status: 404
    end
  end

  def download_order_history
    
    if @user && File.exist?(file_path)
      file_path = Rails.root.join("tmp/#{user.id}_orders.csv")
      send_file file_path, filename: "#{user.name}_orders.csv", type: 'text/csv'
    else
      render json: {
        success:  false,
        message:  "There was some error. Please refresh the page and try again"
      }, status: 404
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end  
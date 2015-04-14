class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def index
    @user = User.find params[:user_id]
    @requests = @user.requests.order created_at: :desc
    @requests = @requests.paginate page: params[:page], per_page: 10
  end

  def create
    @user = User.find params[:user_id]
    @request = @user.requests.build request_params
    if @request.save
      params[:picture_uploads].each do |p|
        @picture = @request.pictures.create!(picture: p, request_id: @request.id)
      end
      flash[:success] = "Request created!"
      redirect_to user_requests_path @user
    else
      render 'new'
    end
  end

  def new
    @user = User.find params[:user_id]
    @request = Request.new
    @picture = @request.pictures.build
  end

  def show
    @user = User.find params[:user_id]
    @request = Request.find params[:id]
    @pictures = @request.pictures
  end

  def destroy
    @request = Request.find params[:id]
    @request.destroy
    flash[:success] = "Request cancelled"
    redirect_to user_requests_path
  end

  private

  def request_params
    params.require :user_id
    params.require(:request).permit :title, :content, pictures_attributes: [:id, :request_id, :picture]

  end

  def correct_user
    @user = User.find params[:user_id]
    redirect_to root_url unless current_user == @user
  end
end

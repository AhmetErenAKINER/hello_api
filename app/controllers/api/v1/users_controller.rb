module Api
  module V1
    class UsersController < ApplicationController
      def index; render json: User.all; end
      def show;  render json: User.find(params[:id]); end
      def create
        r = User.new(user_params)
        r.save ? render(json: r, status: :created) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def update
        r = User.find(params[:id])
        r.update(user_params) ? render(json: r) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def destroy; User.find(params[:id]).destroy; head :no_content; end
      private
      def user_params; params.require(:user).permit(:name, :email); end
    end
  end
end

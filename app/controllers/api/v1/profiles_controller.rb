module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :set_user
      def show;    render json: @user.profile; end
      def create
        p = @user.build_profile(profile_params)
        p.save ? render(json: p, status: :created) : render(json: { errors: p.errors.full_messages }, status: :unprocessable_entity)
      end
      def update
        p = @user.profile
        p.update(profile_params) ? render(json: p) : render(json: { errors: p.errors.full_messages }, status: :unprocessable_entity)
      end
      def destroy; @user.profile&.destroy; head :no_content; end
      private
      def set_user; @user = User.find(params[:user_id]); end
      def profile_params; params.require(:profile).permit(:bio); end
    end
  end
end

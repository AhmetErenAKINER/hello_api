module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts = params[:user_id] ? User.find(params[:user_id]).posts : Post.all
        render json: posts, include: [:user, :category]
      end
      def show; render json: Post.find(params[:id]), include: [:user, :category, :comments]; end
      def create
        r = Post.new(post_params)
        r.save ? render(json: r, status: :created) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def update
        r = Post.find(params[:id])
        r.update(post_params) ? render(json: r) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def destroy; Post.find(params[:id]).destroy; head :no_content; end
      private
      def post_params; params.require(:post).permit(:title, :body, :user_id, :category_id); end
    end
  end
end

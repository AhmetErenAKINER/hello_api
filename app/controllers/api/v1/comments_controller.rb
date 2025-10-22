module Api
  module V1
    class CommentsController < ApplicationController
      def index; render json: Post.find(params[:post_id]).comments; end
      def show;  render json: Comment.find(params[:id]); end
      def create
        r = Comment.new(comment_params)
        r.save ? render(json: r, status: :created) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def update
        r = Comment.find(params[:id])
        r.update(comment_params) ? render(json: r) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def destroy; Comment.find(params[:id]).destroy; head :no_content; end
      private
      def comment_params; params.require(:comment).permit(:body, :user_id, :post_id); end
    end
  end
end

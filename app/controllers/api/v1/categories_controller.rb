module Api
  module V1
    class CategoriesController < ApplicationController
      def index; render json: Category.all; end
      def show;  render json: Category.find(params[:id]); end
      def create
        r = Category.new(category_params)
        r.save ? render(json: r, status: :created) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def update
        r = Category.find(params[:id])
        r.update(category_params) ? render(json: r) : render(json: { errors: r.errors.full_messages }, status: :unprocessable_entity)
      end
      def destroy; Category.find(params[:id]).destroy; head :no_content; end
      private
      def category_params; params.require(:category).permit(:name); end
    end
  end
end

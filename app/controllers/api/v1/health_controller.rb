module Api
  module V1
    class HealthController < ApplicationController
      def index
        render json: { message: "hello" }
      end
    end
  end
end

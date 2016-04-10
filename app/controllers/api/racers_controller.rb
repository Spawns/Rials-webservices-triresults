module Api
  class RacersController < ApplicationController


    def index
      if !request.accept || request.accept == "*/*"
        render plain: api_racers_path
      end
    end

    def show
      # if !request.accept || request.accept == "*/*"
      #   render plain: "/api/racers/#{params[:racer_id]}"
      # else
      #   @races=@racer.races
      #   render json: @racers, status:200
      # end
      if !request.accept || request.accept == "*/*"
         render plain: api_racer_path(params[:id])
      end
    end
  end
end

module Api
  class RacesController < ApplicationController



    def index
      # if !request.accept || request.accept == "*/*"
      #   render plain: "/api/races"
      # else
      #   # @races = Race.all.order_by(date: :desc)
      #   # render json: @races, status:200
      #   render plain: api_races_path
      # end
      if !request.accept || request.accept == "*/*"
        if !params[:offset].nil? and !params[:limit].nil?
          render plain: "#{api_races_path}, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
        else
          render plain: api_races_path
        end
      end
    end

    def show
      # if !request.accept || request.accept == "*/*"
      #   render plain: "/api/races/#{params[:race_id]}"
      # else
      #   # @race = Race.find(params[:id])
      #   # render json: @race, status: 200
      #   @race = Race.find(params[:id])
      #   render :show
      # end
      if !request.accept || request.accept == "*/*"
         render plain: api_race_path(params[:id])
       else
         @race = Race.find(params[:id])
         render :show
       end
    end

    def create
      if !request.accept || request.accept == "*/*"
        if !params[:race].nil?
          render plain: params[:race][:name]
        else
          render plain: :nothing, status: :ok
        end
      else
        if !params[:race].nil?
          Race.create(race_params)
          render plain: race_params[:name], status: :created
        end
      end
    end

    def update
      race = Race.find(params[:id])
      race.update(race_params)
      render json: race
    end

    def destroy
      race = Race.find(params[:id])
      race.destroy
      render :nothing=>true, :status=>:no_content
    end
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      #byebug
      render :status=>:not_found,
        :template=>"api/races/error_msg",
        :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]" }
    end

    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.debug exception
      render plain: "woops: we do not support that content-type[#{request.accept}]",
        :status=>:unsupported_media_type

    end
    private

      # Never trust parameters from the scary internet, only allow the white list through.
      def race_params
        params.require(:race).permit(:name, :date)
      end
  end
end

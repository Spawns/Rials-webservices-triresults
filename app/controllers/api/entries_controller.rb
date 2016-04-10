module Api
  class EntriesController < ApplicationController

    def index
      if !request.accept || request.accept == "*/*"
        render plain: api_racer_entries_path(params[:racer_id])
      end
    end

    def show
      # if !request.accept || request.accept == "*/*"
      #   render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
      # else
      # #real implementation ...
      #   byebug
      # end
      if !request.accept || request.accept == "*/*"
        render plain: api_racer_entry_path(params[:racer_id], params[:id])
      end
    end
  end
end

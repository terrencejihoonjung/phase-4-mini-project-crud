class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    wrap_parameters format:[]

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        new_spice = Spice.create(spice_params)
        render json: new_spice, status: :created
    end

    def update
        update_spice = find_spice
        update_spice.update(spice_params)
        render json: update_spice
    end

    def destroy
        destroy_spice = find_spice
        destroy_spice.destroy
        head :no_content
    end

    private
    def find_spice
        Spice.find(params[:id])
    end
    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
    def render_not_found_response
        render json: {error: "spice not found"}, status: :not_found
    end
end

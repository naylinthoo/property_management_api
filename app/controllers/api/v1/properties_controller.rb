module Api
  module V1
    class PropertiesController < ApplicationController
      before_action :set_property, only: [:show, :update, :destroy]

      def index
        properties = Property.all
        render json: properties
      end

      def show
        render json: @property
      end

      def create
        property = Property.new(property_params)
        if property.save
          render json: property, status: :created
        else
          render json: property.errors, status: :unprocessable_entity
        end
      end

      def update
        if @property.update(property_params)
          render json: @property
        else
          render json: @property.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @property.destroy
        head :no_content
      end

      def vacant
        vacant_properties = Property.where(status: 'vacant')
        render json: vacant_properties
      end

      private

      def set_property
        @property = Property.find(params[:id])
      end

      def property_params
        params.require(:property).permit(:name, :address, :owner_name, :monthly_rent, :status)
      end
    end
  end
end

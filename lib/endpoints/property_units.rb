module Endpoints
  class PropertyUnits < Base
    namespace "/properties/:property_id/units" do
      before do
        halt(401) unless session[:account_id]
        content_type :json, charset: 'utf-8'
      end

      get do
        encode serialize(PropertyUnit.where(
          property_id: params[:property_id], 
          account_id: session[:account_id])
        )
      end

      post do
        property_unit = PropertyUnit.new
        property_unit.property_id = params[:property_id]
        property_unit.account_id = session[:account_id]
        property_unit.save
        status 201
        encode serialize(property_unit)
      end

      get "/:id" do |property, id|
        property_unit = PropertyUnit.first(
          id: params[:id], 
          account_id: session[:account_id]
        ) || halt(404)
        encode serialize(property_unit)
      end

      patch "/:id" do |property_id, id|
        property_unit = PropertyUnit.first(
          id: params[:id], 
          account_id: session[:account_id]
        ) || halt(404)
        # warning: not safe
        #property_unit.update(body_params)
        encode serialize(property_unit)
      end

      delete "/:id" do |property_id, id|
        property_unit = PropertyUnit.first(
          id: params[:id],
          account_id: session[:account_id]
        ) || halt(404)
        property_unit.destroy
        encode serialize(property_unit)
      end

      private

      def serialize(data, structure = :default)
        Serializers::PropertyUnit.new(structure).serialize(data)
      end
    end
  end
end

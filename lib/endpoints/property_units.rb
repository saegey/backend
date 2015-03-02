module Endpoints
  class PropertyUnits < Base
    namespace "/v1/properties/:property_id/units" do
      before do
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get do
        encode serialize(PropertyUnit.where(
          property_id: params[:property_id], 
          account_id: session[:account_id])
        )
      end

      post do
        data =  MultiJson.decode(request.env["rack.input"].read)

        property_unit = PropertyUnit.new
        property_unit.property_id = params[:property_id]
        property_unit.account_id = session[:account_id]
        property_unit.pin_code = data["pin_code"]

        if property_unit.valid?
          status 201
          property_unit.save
          encode serialize(property_unit)
        else
          status 400
          encode property_unit.errors
        end
      end

      get "/:id" do |property, id|
        property_unit = PropertyUnit.first(
          id: params[:id], 
          account_id: session[:account_id]
        ) || halt(404)
        encode serialize(property_unit)
      end

      patch "/:id" do |property_id, id|
        data =  MultiJson.decode(request.env["rack.input"].read)

        property_unit = PropertyUnit.first(
          id: params[:id], 
          account_id: session[:account_id]
        ) || halt(404)

        property_unit.property_id = data["property_id"] if data.include? 'property_unit'
        property_unit.pin_code = data["pin_code"] if data.include? 'pin_code'

        if property_unit.valid?
          property_unit.save
          status 201
          encode serialize(property_unit)
        else
          status 400
          encode property_unit.errors
        end
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

module Endpoints
  class PropertyUnits < Base
    namespace "/v1/properties/:property_id/units" do
      before do
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get do
        property_units = PropertyUnit.where(
          property_id: params[:property_id], 
          account_id: session[:account_id]
        ) || halt(404)

        encode serialize(property_units)
      end

      post do
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        property_unit = PropertyUnit.new
        property_unit.set(
          property_id: params[:property_id],
          account_id: session[:account_id],
          phone_number: params[:phone_number]
        )

        if property_unit.valid?
          property_unit.save
          status 201
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
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        property_unit = PropertyUnit.first(
          id: params[:id],
          account_id: session[:account_id]
        ) || halt(404)

        property_unit.update(
          property_id: params[:property_id],
          phone_number: params[:phone_number]
        )

        if property_unit.valid?
          property_unit.save
          status 200
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

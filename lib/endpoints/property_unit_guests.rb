module Endpoints
  class PropertyUnitGuests < Base
    namespace "/property-unit-guests" do
      before do
        # check_version!
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get do
        guests = PropertyUnitGuest.where(account_id: session[:account_id]) || halt(404)
        encode serialize(guests)
      end

      post do
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        property_unit_guest = PropertyUnitGuest.new
        property_unit_guest.set(
          property_unit_id: params[:property_unit_id],
          account_id: session[:account_id],
          email: params[:email],
          pin_code: params[:pin_code],
          phone_number: params[:phone_number]
        )

        if property_unit_guest.valid?
          property_unit_guest.save
          status 201
          encode serialize(property_unit_guest)
        else
          status 400
          encode property_unit_guest.errors
        end
      end

      get "/:id" do |id|
        property_unit_guest = PropertyUnitGuest.first(
          id: params[:id],
          account_id: session[:account_id]
        ) || halt(404)
        encode serialize(property_unit_guest)
      end

      patch "/:id" do |id|
        params.merge! MultiJson.decode(request.env["rack.input"].read)
        property_unit_guest = PropertyUnitGuest.first(id: id) || halt(404)
        property_unit_guest.set(
          email: params[:email],
          pin_code: params[:pin_code],
          phone_number: params[:phone_number]
        )
        if property_unit_guest.valid?
          property_unit_guest.save
          encode serialize(property_unit_guest)
        else
          status 400
          encode property_unit_guest.errors
        end
      end

      delete "/:id" do |id|
        property_unit_guest = PropertyUnitGuest.first(
          id: params[:id],
          account_id: session[:account_id]
        ) || halt(404)
        property_unit_guest.destroy
        encode serialize(property_unit_guest)
      end

      private

      def serialize(data, structure = :default)
        Serializers::PropertyUnitGuest.new(structure).serialize(data)
      end
    end
  end
end

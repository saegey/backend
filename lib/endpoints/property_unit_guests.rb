module Endpoints
  class PropertyUnitGuests < Base
    namespace "/property_unit_guests" do
      before do
        check_version!
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get do
        guests = PropertyUnitGuest.where(account_id: session[:account_id]) || halt(404)
        encode serialize(guests)
      end

      post do
        # warning: not safe
        property_unit_guest = PropertyUnitGuest.new(body_params)
        property_unit_guest.save
        status 201
        encode serialize(property_unit_guest)
      end

      get "/:id" do |id|
        property_unit_guest = PropertyUnitGuest.first(id: id) || halt(404)
        encode serialize(property_unit_guest)
      end

      patch "/:id" do |id|
        property_unit_guest = PropertyUnitGuest.first(uuid: id) || halt(404)
        # warning: not safe
        #property_unit_guest.update(body_params)
        encode serialize(property_unit_guest)
      end

      delete "/:id" do |id|
        property_unit_guest = PropertyUnitGuest.first(uuid: id) || halt(404)
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

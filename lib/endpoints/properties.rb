module Endpoints
  class Properties < Base
    namespace "/properties" do
      before do
        halt(401) unless session[:user_id]
        content_type :json, charset: 'utf-8'
      end

      get do
        encode serialize(Property.where(account_id: session[:account_id]))
      end

      post do
        property = Property.new
        property.name = params['name']
        property.account_id = session[:account_id]

        if property.valid?
          property.save
          status 201
          encode serialize(property)
        else
          encode property.errors
        end
      end

      get "/:id" do
        property = Property.first(
          id: params[:id], 
          account_id: session[:account_id]
        ) || halt(404)
        encode serialize(property)
      end

      patch "/:id" do |id|
        property = Property.first(
          id: params['id'],
          account_id: session[:account_id]
        ) || halt(404)
        
        property.name = params['name']
        
        if property.valid?
          property.save
          encode serialize(property)
        else
          encode property.errors
        end
      end

      delete "/:id" do |id|
        property = Property.first(
          id: params['id'],
          account_id: session[:account_id]
        ) || halt(404)
        property.destroy
        encode serialize(property)
      end

      private

      def serialize(data, structure = :default)
        Serializers::Property.new(structure).serialize(data)
      end
    end
  end
end

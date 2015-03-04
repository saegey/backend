module Endpoints
  class Properties < Base
    namespace "/v1/properties" do
      before do
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get do
        properties = Property.where(account_id: session[:account_id])
        encode serialize(properties)
      end

      post do
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        property = Property.new
        property.set(
          name: params[:name],
          account_id: session[:account_id],
          outbound_phone_numbers: params[:outbound_phone_numbers]
        )

        if property.valid?
          property.save
          status 201
          encode serialize(property)
        else
          status 400
          encode property.errors
        end
      end

      get "/:id" do
        property = Mediators::AccountProperty.run(
          id: params[:id], 
          account_id: session[:account_id]
        )
        encode serialize(property)
      end

      patch "/:id" do |id|
        params.merge! MultiJson.decode(request.env["rack.input"].read)
        
        property = Mediators::AccountProperty.run(
          id: params[:id], 
          account_id: session[:account_id]
        )
        
        property.update(
          name: params[:name],
          outbound_phone_numbers: params[:outbound_phone_numbers]
        )
        
        if property.valid?
          property.save
          encode serialize(property)
        else
          encode property
        end
      end

      delete "/:id" do |id|
        property = Mediators::AccountProperty.run(
          id: params[:id], 
          account_id: session[:account_id]
        )
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

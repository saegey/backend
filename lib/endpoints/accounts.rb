module Endpoints
  class Accounts < Base
    namespace "/accounts" do
      before do
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get "/:id" do |id|
        account = Account.first(id: session[:account_id]) || halt(404)
        encode serialize(account)
      end

      patch "/:id" do |id|
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        account = Account.first(id: session[:account_id]) || halt(404)
        account.user_id = params[:user_id]
        if account.valid?
          account.save
          status 200
          encode serialize(account)
        else
          status 400
          encode account.errors
        end
      end

      delete "/:id" do |id|
        account = Account.first(id: session[:account_id]) || halt(404)
        account.destroy
        encode serialize(account)
      end

      private

      def serialize(data, structure = :default)
        Serializers::Account.new(structure).serialize(data)
      end
    end
  end
end

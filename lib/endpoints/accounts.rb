module Endpoints
  class Accounts < Base
    namespace "/v1/accounts" do
      before do
        authorize!
        content_type :json, charset: 'utf-8'
      end

      get "/:id" do |id|
        account = Account.first(id: id) || halt(404)
        encode serialize(account)
      end

      patch "/:id" do |id|
        account = Account.first(id: id) || halt(404)

        # warning: not safe
        #account.update(body_params)
        encode serialize(account)
      end

      delete "/:id" do |id|
        account = Account.first(id: id) || halt(404)
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

module Requests
  module JsonHelpers
    def json
      @json ||= RecursiveOpenStruct.new(JSON.parse(last_response.body))
    end
  end
end

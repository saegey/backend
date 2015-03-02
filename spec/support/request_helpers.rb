module Requests
 module JsonHelpers
  def json
    data = JSON.parse(last_response.body)
    if data.is_a?(Array)
      @json = []
      data.each do |d|
        @json << RecursiveOpenStruct.new(d)
      end
      @json
    else
      @json ||= RecursiveOpenStruct.new(data)
    end
  end
 end
end

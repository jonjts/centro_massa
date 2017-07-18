module Api::V1
  class BaseController < ActionController::Base
    before_filter :permitir_parametros
    before_filter :parse_request, :except => [:index]


    def parse_request
      @json = JSON.parse(request.body.read)
    end

    def permitir_parametros
      params.permit!
    end
  end
end

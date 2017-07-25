module Api::V1
  class UsuariosController < BaseController

    before_filter only: :login do
      unless @json.has_key?('usuario') &&
          @json['usuario']['email'] &&
          @json['usuario']['nome'] &&
          render json: "Dados para o cadastro não validos.", status: :bad_request
      end
    end

    def login
      @user = Usuario.where(email: @json['usuario']["email"]).take
      if @user.blank?
        @user = Usuario.new
        @user.from_json(@json['usuario'].to_json)
        unless @user.save
          render json: @user.errors.full_messages.to_sentence, status: :bad_request
          return true
        end
      end
      successes_login
    end

    private

    def successes_login
      render json: @user, status: :success
      return true
    end

  end
end

module Api::V1
  class UsuariosController < BaseController

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

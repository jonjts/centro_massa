module Api::V1
  class PontuacaoController < BaseController

    before_filter only: :create do
      unless @json.has_key?('pontuacao') &&
          @json['pontuacao']['pontos'] &&
          @json['pontuacao']['fase'] &&
          render json: "Dados para o cadastro não validos.", status: :bad_request
      end
    end

    def create
      @user = Usuario.where(email: params[:user_email]).take
      unless @user.blank?
        @pontuacao = Pontuacao.new
        @pontuacao.from_json(@json['pontuacao'].to_json)
        @pontuacao.user = @user
        unless @pontuacao.save
          render json: @pontuacao.errors.full_messages.to_sentence, status: :bad_request
          return true
        end
      end
      successes_create
    end

    def successes_create
      render json: @pontuacao, status: :success
      return true
    end

  end
end

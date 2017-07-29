module Api::V1
  class PontuacoesController < BaseController

    def create
      @user = Usuario.where(email: params[:user_email]).take
      unless @user.blank?
        @pontuacao = Pontuacao.new
        @pontuacao.from_json(@json['pontuacao'].to_json)
        @pontuacao.usuario = @user
        unless @pontuacao.save
          render json: @pontuacao.errors.full_messages.to_sentence, status: :bad_request
          return true
        end
      end
      successes_create
    end

    def index
      @pontuacoes = Pontuacao.order(fase: :desc, pontos: :desc).
        limit(40)
      render json: @pontuacoes.to_json(:include => :usuario), status: :success
    end

    def successes_create
      render json: @pontuacao, status: :success
      return true
    end

  end
end

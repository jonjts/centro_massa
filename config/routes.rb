Rails.application.routes.draw do

  scope :api do
    scope :v1 do
      scope :usuarios do
        get '/' => 'api/v1/usuarios#index'
        scope :login do
          put '/' => 'api/v1/usuarios#login'
        end
      end
    end
  end

end

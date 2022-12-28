class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authorized

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :render_not_unique


    def encode_token(payload)
        JWT.encode(payload, 's3cr3t')
    end
    
    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
    end
    
    def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          # header: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
    end
    
    def logged_in_user
        reuslt_token = decoded_token
        if reuslt_token
          user_id = reuslt_token[0]['user_id']
          @user = User.find_by(id: user_id)
        end
    end
    
    def logged_in?
        !!logged_in_user
    end
    
    def authorized
        render json: { message: 'Please log in!' }, status: :unauthorized unless logged_in?
    end
    




    private

    def render_not_found(exception)
        render json: {error: exception.message}, status: :not_found
    end

    def render_invalid(invalid)
        render json: invalid.record.errors, status: :unprocessable_entity
    end

    def render_not_unique(exception)
        render json: exception.message, status: :unprocessable_entity
    end

    # Must implement authorized? method
    def render_not_authorized
        if !authorized?
            render json: { error: 'Operação não permitida para o usuário autentificado' }, 
                status: :unauthorized
        end
    end
end

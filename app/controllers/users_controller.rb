class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        user = User.create(user_params)
        
        if user.valid?
            @token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: @token }, status: :created
        else
            render json: {errors: user.errors}, status: :unprocessable_entity
        end
    end

    def me
        render json: {user: UserSerializer.new(current_user)}, status: :accepted
    end

    # def search
    #     set_current_user
    #     if params[:query] == nil
    #         render json: {error: "Blank search queries will not be accepted."}, status: :unprocessable_entity
    #     else

    #         search_results = User.where("username like ?", "%#{params[:query]}%")
    #         render json: search_results, current_user: @user, status: :ok

    #     end
    # end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end

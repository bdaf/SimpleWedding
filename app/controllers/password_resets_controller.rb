class PasswordResetsController < ApplicationController
    before_action :set_user_by_token, only: [:edit, :update]
    def new
    end

    def create
        if (user = User.find_by(email: params[:email]))
            PasswordMailer.with(
                user: user,
                token: user.generate_token_for(:password_reset)
            ).password_reset.deliver_later
        end
        flash[:notice] = "Check your email to confirm password reset." 
        redirect_to root_path
    end

    def edit
    end

    def update
        if @user.update(password_params)
            flash[:notice] = "Your password has been changed!"
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private
    
    def set_user_by_token
        @user = User.find_by_token_for(:password_reset, params[:token])
        unless @user.present?
            flash[:alert] = "Invalid token, please try again from the start."
            redirect_to new_password_reset_path unless @user.present?
        end
    end

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
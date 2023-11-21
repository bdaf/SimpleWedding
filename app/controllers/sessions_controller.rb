class SessionsController < ApplicationController

    def new
    end

    def create
        if user = User.authenticate_by(email: params[:email], password: params[:password])
            login user
            flash[:success] = "You have beed signed in!"
            redirect_to root_path
        else
            flash.now[:alert] = "Invalid email or password."
            render :new, status: :unprocessable_entity
        end
    end
    
    
    def destroy 
        logout
        flash[:info] = "You have been logged out!"
        redirect_to root_path
    end
end
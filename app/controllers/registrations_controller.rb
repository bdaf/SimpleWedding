class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    if @user.save
      login @user
      flash[:notice] = "Account has been created!"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong, see hints below!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :city, :phone_number, :celebration_date)
  end
end
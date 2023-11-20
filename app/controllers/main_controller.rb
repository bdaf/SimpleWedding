class MainController < ApplicationController
  def index
    flash[:notice] = "Hey, you are in the home page of our app, enjoy information in this form in entire app!"
    flash[:alert] = "In this form alerts will be showing themself!"
    flash[:success] = "In this form success messages will be showing themself!"
    flash[:error] = "In this form errors will be showing themself!"
  end
end
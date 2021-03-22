class SessionsController < ApplicationController
  def new

  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      if user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:notice] = "Connexion réussie !"
        redirect_to user
      else
        flash.now[:alert] = "Wrong credentials"
        render 'new'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Déconnexion réussie !"
    redirect_to root_path
  end
end

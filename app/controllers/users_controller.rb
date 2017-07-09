class UsersController < ApplicationController 
  
  def new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/', notice: 'Account Created: Thank you for Choosing Jungle!'
    else
      redirect_to '/signup', notice: 'Error: Please Ensure all Fields are Filled out Correctly.'
    end
  end

  
  private

  def user_params
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email, 
      :password, 
      :password_confirmation)
  end
  
end

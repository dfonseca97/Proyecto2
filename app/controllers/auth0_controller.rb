class Auth0Controller < ApplicationController
  def callback
   begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome!"
    rescue
      flash[:warning] = "There has been an error when signin in"
    end
    redirect_to root_path
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'You have signed out correctly!'
    end
    redirect_to root_path
  end
end

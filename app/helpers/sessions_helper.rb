module SessionsHelper

  # Logs in the given user.
  def log_in(user)

    session[:user_id] = user.id
    @current_user = user
    remember user
  end
 
  def remember(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_digest
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    remember_digest = cookies.permanent[:remember_token]
    @current_user ||= User.find_by(remember_digest: remember_digest)
  end

  def current_user=(user)
    @current_user = user
  end

  # def current_user
	 #  if (user_id = session[:user_id])
	 #    @current_user ||= User.find_by(id: user_id)
	 #  elsif (user_id = cookies.signed[:user_id])
	 #    user = User.find_by(id: user_id)
	 #    if user && user.authenticated?(cookies[:remember_token])
	 #      log_in user
	 #      @current_user = user
	 #    end
	 #  end
  # end

  # Returns true if the user is logged in, false otherwise.
   def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
  	forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Forgets a user.
  def forget(user)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end



end

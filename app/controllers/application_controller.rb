class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    # if theres authenticated user, return the user obj
    # else return nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    end
  end

  # def vote(obj)
  #   require_user
  #   @vote = Vote.create(voteable: obj, creator: current_user, vote: params[:vote])
  #   if @vote.valid?
  #     flash[:notice] = "Your vote was counted"
  #   else
  #     flash[:error] = "You can only vote for this once"
  #   end
  #
  #   redirect_to :back
  # end

end

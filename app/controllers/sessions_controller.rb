class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      @url = root_path
      respond_to do |format|
        format.turbo_stream { render "shared/redirect" }
        format.html { redirect_to @url }
      end
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session

    # if hotwire_native?
    #   cookies.signed.permanent[:refresh_url_after_login] = request.referrer
    # end

    refresh_or_redirect_to new_session_path
  end
end
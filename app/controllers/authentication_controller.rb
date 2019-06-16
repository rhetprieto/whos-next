class AuthenticationController < ApplicationController

  before_action :authorize_refresh_by_access_request!, only:[:refresh]

  def create
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      payload  = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
  end

  def refresh
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens = session.refresh_by_access_payload do
      raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
    end
    response.set_cookie(JWTSessions.access_cookie,
                        value: tokens[:access],
                        httponly: true,
                        secure: Rails.env.production?)

    render json: { csrf: tokens[:csrf] }
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

end

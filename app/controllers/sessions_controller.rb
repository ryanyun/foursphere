require 'open-uri'
class SessionsController < ApplicationController
  def index
    if current_user
      data = [['checkins', []]]
      n = JSON.parse(open("https://api.foursquare.com/v2/users/self/venuehistory?oauth_token=#{session[:tk]}&v=20151202").read)['response']['venues']['count'] / 250 + 1
      pg = 0
      while pg < n
        JSON.parse(open("https://api.foursquare.com/v2/users/self/venuehistory?oauth_token=#{session[:tk]}&v=20151202&limit=250&offset=#{pg * 250}").read)['response']['venues']['items'].each do |c|
          data.first.last << c['venue']['location']['lat']
          data.first.last << c['venue']['location']['lng']
          data.first.last << c['beenHere'] * 0.1
        end
        pg += 1
      end
      gon.data = data.to_s
    end
  end
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:tk] = auth['credentials']['token']
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    session[:tk] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
  
  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end
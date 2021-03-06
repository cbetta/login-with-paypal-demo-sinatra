require "sinatra"
require "paypal-sdk-rest"

include PayPal::SDK::OpenIDConnect

get "/" do
  redirect Tokeninfo.authorize_url({
    scope: "openid profile",
    redirect_uri: "http://127.0.0.1:9292/callback"
  })
end

get "/callback" do
  tokeninfo = Tokeninfo.create(params["code"])

  userinfo = tokeninfo.userinfo

  "Hello #{userinfo.name}, you have a #{userinfo.account_type} account and your address is #{"not" if userinfo.verified_account} verified"
end

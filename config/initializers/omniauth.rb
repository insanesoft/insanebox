OmniAuth.config.full_host = "http://localhost:3000"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"],
           {
               :name => "google",
               :scope => "userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com",
               :prompt => "select_account",
               :image_aspect_ratio => "square",
               :image_size => 50
           }
end
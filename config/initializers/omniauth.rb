OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
           {
               name: 'google',
               scope: 'userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com',
               prompt: 'select_account',
               image_aspect_ratio: 'square',
               image_size: 50,
               access_type: 'offline',
               #prompt: 'consent',
               #scope: 'https://www.googleapis.com/auth/userinfo.email',
               redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback'
           }
end
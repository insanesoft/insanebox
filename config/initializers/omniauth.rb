OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           '775380574040-lf6i6gn8a0rka8vu2kq6fo5b9gga5nba.apps.googleusercontent.com',
           'MkAeCmEwrh3C6AWso-0Z25rP',
           {
               access_type: 'offline',
               prompt: 'consent',
               scope: 'https://www.googleapis.com/auth/userinfo.email',
               redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
           }
end
# Be sure to restart your server when you modify this file.

# This will tell Rails to use the cache_store of the
# application as the underlying session store as well

Insanebox::Application.config.
    session_store ActionDispatch::Session::CacheStore,
                  expires_after: 20.minutes

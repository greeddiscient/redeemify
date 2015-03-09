Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '4bUmNUQl5SgJuuuWcWuzIULkS', 'CvFiQWRNvAO7JXWFFDyiNsLVvPbUhyGUOmsBSMUsmGw2CDtJYQ'
  provider :google_oauth2, '850083876126-h3r2ujqiu1e6enifhjeb5uo2uidhguer.apps.googleusercontent.com', '8ixrZnsfH8NFCpLHEFqktmrM'
  provider :facebook, '289615254495412', '94cdb6552e5e5e19236fbd7d6b0c521e'
end

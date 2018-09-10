Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'zsI86wyukT72zD0nB7y7l2WSt7LDf67I',
    '48zWyJdZ53uFaCes1XShZ5yyfzuUEOUnF5OfG6Ivlgogl-IqJxvvGf1V9DSZr8Eg',
    'topicosp2.auth0.com',
    callback_path: '/auth/oauth2/callback',
    authorize_params: {
      scope: 'openid profile',
      audience: 'https://topicosp2.auth0.com/userinfo'
    }
  )
end

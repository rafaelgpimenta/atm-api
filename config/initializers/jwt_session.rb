JWTSessions.algorithm = "HS256"
if Rails.env.test?
  JWTSessions.encryption_key = 'secret'
  JWTSessions.token_store = :memory
else
  JWTSessions.encryption_key = ENV['JWT_SECRET']
end

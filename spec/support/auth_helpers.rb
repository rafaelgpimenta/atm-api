module AuthHelpers
  def login(customer)
    payload = { customer_id: customer.id }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    session.login
  end

  def auth_header(pub_key)
    { JWTSessions.access_header => "Bearer #{pub_key}" }
  end
end

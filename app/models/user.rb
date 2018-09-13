class User < ApplicationRecord
  
    class << self
      # Crea u obtiene el usuario de un ingreso mediante Oauth
      def from_omniauth(auth_hash)
        user = find_or_create_by(uid: auth_hash['uid'])
        user.email = auth_hash['info']['name']
        user.timezone = auth_hash['extra']['raw_info']['https://example.com/timezone']
        user.save!
        user
      end
    end
    
    
  before_create -> {self.token = generate_token}
  private
  
  def generate_token
    loop do
      token = SecureRandom.hex
	      return token unless User.exists?({token: token})
    end
  end
end

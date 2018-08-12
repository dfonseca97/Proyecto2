class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create -> {self.token = generate_token}

  private

    def generate_token
      
      loop do 
         
         token = SecureRandom.hex
         return token unless User.exists?({token: token})
        
        end
    end

end

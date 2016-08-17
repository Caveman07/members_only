class User < ApplicationRecord

	

	before_save { |user| user.email = email.downcase }
	before_create :create_remember_token 
	
	validates :name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
					  format: {with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}
	validates :password, presence: true, length: { minimum:6 }
	has_secure_password
	

	
	  # Remembers a user in the database for use in persistent sessions.
	  # def remember
	  #   self.remember_token = User.new_token
	  #   update_attribute(:remember_digest, remember_token)
	  # end	


	  # Returns true if the given token matches the digest.
	  # def authenticated?(remember_token)
	  # 	return false if remember_digest.nil?
	  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
	  # end 

	 #Forgets a user.
	  # def forget
	  #   update_attribute(:remember_digest, nil)
	  # end


	  #returns a random string
	  def User.new_token 
	  		SecureRandom.urlsafe_base64
	  end

	  #encrypt given a random string(token) using ecryption method
	  def User.encrypt(string)
	  		Digest::SHA1.hexdigest(string.to_s)
	  end


	  private 

		  #assign encrypted token to the class atribute :create_remember_token 
		  def create_remember_token
		  		self.remember_digest = User.encrypt(User.new_token)
		  end
end

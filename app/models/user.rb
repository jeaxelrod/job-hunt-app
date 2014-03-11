class User < ActiveRecord::Base
	
	before_save { self.username = username.downcase }
	before_create :create_remember_token
	validates :username, presence: true, length: { maximum: 50 }, 
						 uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	has_secure_password
	has_many :jobs, dependent: :destroy
	has_many :groups, dependent: :destroy
	has_many :descriptions, through: :jobs
	accepts_nested_attributes_for :jobs

	
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	
	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	
	private
	
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end

class Student < ActiveRecord::Base
  # attr_accessor :remember_token
  has_many :pledges, dependent: :destroy
  before_save { self.netid = netid.downcase }
  validates :netid, presence: true, length: { maximum: 20 },
                    uniqueness: { case_sensitive: false }

 #  # Returns a random token.
 #  def Student.new_token
	# SecureRandom.urlsafe_base64
 #  end

 #  # Returns the hash digest of the given string.
 #  def Student.digest(string)
 #    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
 #                                                  BCrypt::Engine.cost
 #    BCrypt::Password.create(string, cost: cost)
 #  end

 #  # Remembers a student in the database for use in persistent sessions.
 #  def remember
 #    self.remember_token = Student.new_token
 #    update_attribute(:remember_digest, Student.digest(remember_token))
 #  end

 #  # Returns true if the given token matches the digest.
 #  def authenticated?(remember_token)
 #  	return false if remember_digest.nil?
 #    BCrypt::Password.new(remember_digest).is_password?(remember_token)
 #  end

 #  # Forgets a student.
 #  def forget
 #    update_attribute(:remember_digest, nil)
 #  end

end
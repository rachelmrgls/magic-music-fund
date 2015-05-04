class Student < ActiveRecord::Base
  has_many :pledges, dependent: :destroy
  before_save { self.netid = netid.downcase }
  validates :netid, presence: true, length: { maximum: 20 },
                    uniqueness: { case_sensitive: false }
end
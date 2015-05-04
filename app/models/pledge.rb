class Pledge < ActiveRecord::Base
  belongs_to :student
  belongs_to :campaign
  default_scope -> { order(created_at: :desc) }
  validates :student_id, presence: true
  validates :campaign_id, presence: true
  validates :amount, presence: true, :numericality => { :greater_than => 0}
end

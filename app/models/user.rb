class User < ActiveRecord::Base

  attr_accessor :password_confirmation

  has_many :events
  has_many :attendees

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name, :email, :city, :state, :password, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: true
  validate :password_matcher, on: :create

  protected
  def password_matcher
    if self.password != self.password_confirmation
    errors.add(:password_confirmation, "Passwords do not match")
    end
  end

  before_validation :downcase_email

  private
  def downcase_email
    self.email = email.downcase if email.present?
  end
end

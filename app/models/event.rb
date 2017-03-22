class Event < ActiveRecord::Base
  belongs_to :host, class_name: 'User'
  has_many :attendees
  has_many :users, through: :attendees

  validates :name, :date, :city, :state, presence: true
  validate :future_date, on: :create

  def future_date
    if date.present? && date < Date.today
      errors.add(:date, "Must be a future date")
    end
  end

end

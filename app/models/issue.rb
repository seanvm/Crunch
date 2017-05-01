class Issue < ActiveRecord::Base
  include AASM

  aasm column: "state" do
    state :pending, initial: true
    state :in_review
    state :confirmed
    state :development
    state :completed
    state :unverified
    
    after_all_transitions :set_dates

    event :review do
      transitions to: :in_review
    end

    event :confirm do
      transitions to: :confirmed
    end
    
    event :development do
      transitions to: :development
    end
    
    event :completed do
      transitions to: :completed
    end
    
    event :unverified do
      transitions to: :unverified
    end
  end
  
  validates :title, presence: true
  
  def set_dates
    if self.state != 'completed'
      self.update(completed_at: nil)
    end
  end
  
  def self.date_format
    '%m/%d/%Y'
  end
  
  def sla_countdown
    SlaTimeService.call(self)
  end
end

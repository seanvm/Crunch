class Issue < ActiveRecord::Base
  include AASM

  aasm column: "state" do
    state :pending, initial: true
    state :in_review
    state :confirmed
    state :development
    state :completed
    state :unverified

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
  
  def sla_countdown
    SlaTimeService.call(self.severity,self.created_at)
  end
end

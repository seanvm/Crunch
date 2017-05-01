class SlaTimeService < BaseService
  require 'date'
  
  # @param [Object] Issue 
  def initialize(issue)
		@issue = issue
  end

  def call
    return 'N/A' if @issue.state == 'pending'
    now = Date.today
    case @issue.severity
    when 0
      return 'N/A'
    when 1
      due_date = @issue.created_at.to_date + 1.days
    when 2
      due_date = @issue.created_at.to_date + 14.days
    when 3
      due_date = @issue.created_at.to_date + 40.days
    when 4
      due_date = @issue.created_at.to_date + 365.days
    when 5
      return 'No Due Date'
    end
    time_left = (due_date - now).to_i
  end
end

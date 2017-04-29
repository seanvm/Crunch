class SlaTimeService < BaseService
	# @param [String] severity - The severity of the issue
  # @param [String] date - The date to base the SLA countdown on
  def initialize(severity, date)
		@severity = severity
    @date = date
  end

  def call
    
  end
end

class JIRAService < BaseService
  # @param [Object] Issue 
  def initialize(issue)
		@issue = issue
  end

  def call
    return true
  end
end

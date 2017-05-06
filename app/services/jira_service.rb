class JiraService < BaseService
  include HTTParty
  
  # @param [Object] Issue 
  def initialize(issue)
		@issue = issue
    @auth = { username: ENV.fetch("JIRA_USER"), password: ENV.fetch("JIRA_PASS")}
  end

  def call
    options = {basic_auth: @auth }
    self.class.base_uri ENV.fetch("JIRA_URL")
    self.class.get("rest/api/latest/issue/SSP-#{@issue.id}.json", options)
  end
end

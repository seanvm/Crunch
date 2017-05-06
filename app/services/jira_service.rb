class JiraService < BaseService
  include HTTParty
  
  # @param [Object] Issue - Issue Object
  # @param [String] Method_type - Method to dynamically dispatch, one of 'insert', 'put', 'get'
  def initialize(issue,method_type)
		@issue = issue
    @method_type = method_type
    @auth = { username: ENV.fetch("JIRA_USER"), password: ENV.fetch("JIRA_PASS")}
    @headers = { 'Content-Type' => 'application/json' }
  end

  def call
    self.class.base_uri ENV.fetch("JIRA_URL")
    self.send(@method_type) if self.respond_to?(@method_type)
  end
  
  def post
    options = {basic_auth: @auth, body: self.post_data.to_json, headers: @headers}
    response = self.class.post("/rest/api/2/issue/", options)
    self.parse_and_save_response(response)
  end
  
  def put
    options = {basic_auth: @auth, body: self.put_data.to_json, headers: @headers}
    self.class.put("/rest/api/2/issue/#{@issue.remote_id}", options)
  end
  
  def get
    options = {basic_auth: @auth}
    self.class.get("/rest/api/latest/issue/SSP-#{@issue.id}.json", options)
  end
  
  def parse_and_save_response(response)
    parsed_response = JSON.parse(response.body)
    remote_url = self.class.base_uri + '/browse/' + parsed_response["key"]
    @issue.update(remote_id: parsed_response["key"], remote_url: remote_url)
  end
  
  def put_data
    {
      "update": {
        "summary": [{"set": "#{@issue.title}"}],
        "description": [{"set": "#{@issue.description}"}]
      }
    }
  end
  
  def post_data
    {
      "fields": {
        "project": {
          "key": "SSP"
        },
        "summary": "#{@issue.title}",
        "description": "#{@issue.description}",
        "issuetype": {
          "name": "Bug"
        }
      }
    }
  end
end
require 'rails_helper'

describe JiraService, :vcr => true do
  subject(:issue) { Issue.new title: "test rspec title" }
  
  it 'creates an issue in JIRA' do
    VCR.use_cassette('JiraServicePost') do
      response = JiraService.call(issue,'post')
      expect(response).to be_an_instance_of(Hash)
    end
  end
end
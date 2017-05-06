class RemoveExternalUrlIssues < ActiveRecord::Migration
  def change
    remove_column :issues, :external_url
  end
end

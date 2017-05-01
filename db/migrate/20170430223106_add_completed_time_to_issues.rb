class AddCompletedTimeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :completed_at, :datetime
  end
end

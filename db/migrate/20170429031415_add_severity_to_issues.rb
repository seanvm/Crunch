class AddSeverityToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :severity, :integer
  end
end

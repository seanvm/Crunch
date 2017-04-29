class AddSeverityToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :severity, :integer
  end
end

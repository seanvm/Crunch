class AddExternalAttributesToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :remote_url, :string
    add_column :issues, :remote_id, :string
    add_column :issues, :remote_status, :string
  end
end

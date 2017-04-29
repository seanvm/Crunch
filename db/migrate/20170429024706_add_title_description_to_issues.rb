class AddTitleDescriptionToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :title, :string
    add_column :issues, :description, :text
  end
end

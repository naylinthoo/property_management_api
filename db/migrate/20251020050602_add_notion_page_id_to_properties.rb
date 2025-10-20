class AddNotionPageIdToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :notion_page_id, :string
  end
end

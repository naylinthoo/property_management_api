class Property < ApplicationRecord
  has_many :tasks, dependent: :destroy
  
  enum :status, {
    occupied: 'occupied',
    vacant: 'vacant',
    maintenance: 'maintenance'
  }
  
  validates :name, :address, :owner_name, :monthly_rent, :status, presence: true

  after_create :create_notion_page
  after_update :update_notion_page
  after_destroy :delete_notion_page

  private

  def create_notion_page
    response = NotionService.create_property(self)
    update_column(:notion_page_id, response['id']) if response['id']
  end

  def update_notion_page
    return unless notion_page_id.present?
    NotionService.update_property(self)
  end

  def delete_notion_page
    return unless notion_page_id.present?
    NotionService.delete_page(notion_page_id)
  end
end
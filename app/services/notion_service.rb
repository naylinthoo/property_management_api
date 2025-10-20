class NotionService
  NOTION_API_BASE = "https://api.notion.com/v1"

  def self.create_property(property)
    url = "#{NOTION_API_BASE}/pages"
    headers = {
      "Authorization" => "Bearer #{ENV['NOTION_TOKEN']}",
      "Notion-Version" => "2022-06-28",
      "Content-Type" => "application/json"
    }

    body = {
      parent: { database_id: ENV['PROPERTIES_DATABASE_ID'] },
      properties: {
        Name: { title: [{ text: { content: property.name } }] },
        Address: { rich_text: [{ text: { content: property.address } }] },
        "Owner Name": { rich_text: [{ text: { content: property.owner_name } }] },
        "Monthly Rent": { number: property.monthly_rent.to_f },
        Status: { select: { name: property.status.capitalize } }
      }
    }.to_json

    HTTParty.post(url, headers: headers, body: body)
  end

  def self.update_property(property)
    url = "#{NOTION_API_BASE}/pages/#{property.notion_page_id}"
    headers = default_headers
    body = {
      properties: {
        Name: { title: [{ text: { content: property.name } }] },
        Address: { rich_text: [{ text: { content: property.address } }] },
        "Owner Name": { rich_text: [{ text: { content: property.owner_name } }] },
        "Monthly Rent": { number: property.monthly_rent.to_f },
        Status: { select: { name: property.status.capitalize } }
      }
    }.to_json

    HTTParty.patch(url, headers: headers, body: body)
  end

  def self.delete_page(page_id)
    url = "#{NOTION_API_BASE}/blocks/#{page_id}"
    headers = default_headers
    HTTParty.delete(url, headers: headers)
  end

  private

  def self.default_headers
    {
      "Authorization" => "Bearer #{ENV['NOTION_TOKEN']}",
      "Notion-Version" => "2022-06-28",
      "Content-Type" => "application/json"
    }
  end
end

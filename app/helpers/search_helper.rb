module SearchHelper
  def format_data(data)
    data['items'].map do |item|
      {
        name: item['name'],
        url: item['html_url'],
        stars: item['stargazers_count'],
        description: item['description']
      }
    end
  end
end

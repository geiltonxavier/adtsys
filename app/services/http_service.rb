class HttpService
  def self.post(url, params = {})
    response = Net::HTTP.post_form(URI(url), params)
    JSON.parse response.body
  end
end

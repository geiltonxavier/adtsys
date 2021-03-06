class MakeService
  WEBMOTORS_MAKES_URL = 'http://www.webmotors.com.br/carro/marcas'.freeze

  def initialize(http_service = HttpService)
    @http_service = http_service
  end

  def find_all_makes
    webmotors_makes = fetch_makes
    makes_to_import =
      webmotors_makes.keys - Make.find_existing_names(webmotors_makes.keys)
    insert_params = makes_to_import.map do |make|
      { name: make, webmotors_id: webmotors_makes[make] }
    end
    Make.import(insert_params)

    Make.all
  end

  protected

  def fetch_makes
    makes = @http_service.post(WEBMOTORS_MAKES_URL)
    makes.map { |h| [h['Nome'], h['Id']] }.to_h
  end
end

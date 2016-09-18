class ModelService
    WEBMOTORS_MODELS_URL = 'http://www.webmotors.com.br/carro/modelos'.freeze

  def initialize(http_service = HttpService)
    @http_service = http_service
  end

  def find_models_by_make_id(make_id)
    webmotors_models = fetch_models(make_id)
    models_to_import =
    webmotors_models.keys - Model.find_existing_names(webmotors_models.keys)
    insert_params = models_to_import.map do |model|
      { name: model, make_id: make_id}
    end

    Model.import(insert_params)
    Model.where(make_id: make_id)
  end

  protected

  def fetch_models(make_id)
    models = @http_service.post(WEBMOTORS_MODELS_URL, { marca: make_id })
    models.map { |h| [h['Nome'], h['Id']] }.to_h
  end
end

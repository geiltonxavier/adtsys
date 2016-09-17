class HomeController < ApplicationController
  def index
    render :index, locals: {
      makes: find_all_makes
    }
  end

  protected

  def find_all_makes
    uri = URI('http://www.webmotors.com.br/carro/marcas')

    response = Net::HTTP.post_form(uri, {})
    json = JSON.parse response.body

    webmotors_makes = json.map { |h| [h['Nome'], h['Id']] }.to_h
    found_makes = Make.where(name: webmotors_makes.keys).pluck(:name)
    makes_to_import = webmotors_makes.keys - found_makes
    insert_params = makes_to_import.map do |make|
      { name: make, webmotors_id: webmotors_makes[make] }
    end
    ActiveRecord::Base.transaction { Make.create(insert_params) }

    Make.all
  end
end

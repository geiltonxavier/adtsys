class ModelsController < ApplicationController
 
  def index
    @models = ModelService.new.find_models_by_make_id(params[:webmotors_make_id])
  end

end

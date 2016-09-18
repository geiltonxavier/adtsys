class Model < ActiveRecord::Base
  belongs_to :make
  def self.import(models)
    transaction { create(models) }
  end

  def self.find_existing_names(names)
    where(name: names).pluck(:name)
  end
end

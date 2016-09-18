class Make < ActiveRecord::Base
  has_many :models
  def self.import(makes)
    transaction { create(makes) }
  end

  def self.find_existing_names(names)
    where(name: names).pluck(:name)
  end
end

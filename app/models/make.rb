class Make < ActiveRecord::Base
  def self.import(makes)
    transaction { create(makes) }
  end

  def self.find_existing_names(names)
    where(name: names).pluck(:name)
  end
end

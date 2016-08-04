class State < ActiveRecord::Base
	has_many :tasks
  def l_name
    try(:name).try(:mb_chars).try(:downcase)
  end
end

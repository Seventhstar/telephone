class GroupMag < ActiveRecord::Base
has_many :PhoneMags

  def self.sear(search)
    if search
      se = search.upcase
      where('LOWER(name) LIKE ?', "%#{se}%")
    else
      all
    end
  end

end

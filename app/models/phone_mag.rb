class PhoneMag < ActiveRecord::Base
belongs_to :group_mag, :class_name => 'GroupMag', :foreign_key => "group_mag_id"

  def self.search(search)
    if search
      se = search.upcase
      where('name LIKE ? or fio LIKE ? or number LIKE ? or mobile LIKE ? or email LIKE ?', "%#{se}%", "%#{se}%", "%#{se}%", "%#{se}%", "%#{se}%")
    else
      all
    end
  end



end

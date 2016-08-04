class Phone < ActiveRecord::Base                        
# attr_accessible :name, :otdel_id, :position_id, :number, :IP, :CompName
 belongs_to :otdel
 belongs_to :position
 before_save :save_duties_to_suggestion


  def otdel_name
      otdel.name if otdel
  end

  def position_name
      position.name if position
  end


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      if row[7] != nil 
        phone = Phone.find_by_name(row[1])
        if phone 
           phone.IP = row[7]
           phone.CompName = row[8]
           phone.save
        end
      end
    end
  end


  def save_duties_to_suggestion
      if self.Duties
	 self.Duties.split(/[\n]+/).each do |t| 
				if t.length > 2
				    n = t.mb_chars.downcase
				    DutiesSuggestion.where(term: n).first_or_initialize.tap do |suggestion|
					suggestion.save
				   end
				end
			   end
      end
  end



  def self.search(search, dsearch)
    if search
      se = search.mb_chars.downcase
      if dsearch.length >0
        ds = dsearch.mb_chars.downcase
 	      where('(lower(name) LIKE ? OR number LIKE ?) and (Duties like ?)', "%#{se}%", "%#{se}%", "%#{ds}%")
      else 
	       ds = dsearch	       
	       where('lower(name) LIKE ? OR number LIKE ?', "%#{se}%", "%#{se}%")
      end	
      
    else
      all
    end
  end


  def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |phones|
      csv << phones.attributes.values_at(*column_names)
    end
  end
end

end

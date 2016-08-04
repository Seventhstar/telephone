class DutiesSuggestion < ActiveRecord::Base
	def self.terms_for(prefix) 
	        pref = prefix.mb_chars.downcase
		suggestions = where("term like ?","#{pref}_%")
		suggestions.pluck(:term)
	end
	def self.index_duties
		DutiesSuggestion.delete_all()
		Phone.find_each do |phone|
		   phone.save_duties_to_suggestion
			#index_term(statement.content)
			#statement.content.split.each {|t| index_term(t)}
			#if phone.Duties
			#   phone.Duties.split(/[- \n]+/).each do |t| 
			#	if t.length > 2
			#	    n = t.mb_chars.downcase
			#	    index_term(n)
			#	end
			#   end
                        #end
		end
	end

	def self.index_term(term)
		where(term: term.downcase).first_or_initialize.tap do |suggestion|
			suggestion.save

		end
	end

end

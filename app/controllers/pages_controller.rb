class PagesController < ApplicationController
   require 'csv'
   require 'fastercsv'

  def uploaded
      render :text => params.to_json
  end

  def csv_import 
      render :text => params.to_json
  #   return
#      CSV.freach(params[:tempfile]) do |csv|

#      FasterCSV.parse(params[:upload][:csv]) do |cells|

#		 CSV.open("path/to/file.csv", "wb") do |csv|
     n=0
#     @parsed_file.each  do |row|
#        p csv[0]

#     c=CustomerInformation.new
#     c.job_title=row[1]
#     c.first_name=row[2]
#     c.last_name=row[3]
#     if c.save
#        n=n+1
#        GC.start if n%50==0
#     end
 #    end

  #   flash.now[:message]="CSV Import Successful,  #{n} new records added to data base"
   end

end

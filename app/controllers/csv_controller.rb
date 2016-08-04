class CsvController < ApplicationController
require 'csv'

  def import
  end

  def export


    @otdels = Otdel.order(:id)
    @phones = Phone.order(:name)

    p = Axlsx::Package.new
    p.workbook.add_worksheet(:name => "Basic Worksheet") do |sheet|
      sheet.add_row ["First Column", "Second", "Third"]
      sheet.add_row [1, 2, 3]
    end
    p.use_shared_strings = true
    p.serialize('simple.xlsx')

      respond_to do |format|
      format.html
      format.csv { send_data @phones.to_csv }
      format.xls { send_data p }
    end
  end

  def upload_mag
    @col_index = 12
    @data = [] 
    @gr = []
    @pos = []
    
    CSV.foreach(params[:upload][:csv].tempfile, :col_sep => ";") do |row|

	if row[0] != nil && row[1]==nil
	  if @gr.index(row[0]) == nil
             @gr<<row[0]
          end
	end
    end

    @data = @gr

      @gr.each do |grp|
      o = GroupMag.find_by_name( grp )
      if o == nil
         o = GroupMag.new( :name => grp )
         o.save
      end
    end

    current_group = 0
    PhoneMag.delete_all()

    CSV.foreach(params[:upload][:csv].tempfile, :col_sep => ";") do |row|

	if row[0] != nil && row[1]==nil

           gr_mag = GroupMag.find_by_name(row[0])
	   current_group = gr_mag.id

        else

           if row[0] != nil
              @name = row[1]
              @fio  = row[2]
              @number = row[3]
              @email  = row[4]
              @work_time = row[5]

#	      ph = PhoneMag.new( :name => @name, :fio => @fio, :number => @number, :email => @email, :work_time => @work_time, :group_mag_id =>current_group)
 #             ph.save

           elsif row[1] != nil || row[2]!=nil

              if @name && row[1]
                 @name.concat("</br>").concat(row[1])
              end

              if @fio && row[2]
                 @fio.concat("</br>").concat(row[2])
              end

              if @number && row[3]
                 @number.concat("</br>").concat(row[3])
              end

              @mobile = row[4]

              if @work_time && row[5]
                 @work_time.concat("</br>").concat(row[5])
              end


             ph = PhoneMag.new( :name => @name, :fio => @fio, :number => @number, :email => @email, :work_time => @work_time, :mobile => @mobile, :group_mag_id =>current_group )
             ph.save
           end
	end



    end




  end

  def upload
    @col_index = 12
    @data = [] 
    @otd = []
    @pos = []

    params[:upload]

    Otdel.delete_all()
    Position.delete_all()
    Phone.delete_all()
    
    CSV.foreach(params[:upload][:avatar].tempfile, :col_sep => ";") do |row|
	if row[1] == nil && row[2]!=nil
	  if @otd.index(row[2]) == nil
             @otd<<row[2]
          end
        else
          if row[2]!=nil 
  	    if @pos.index(row[2]) == nil
  	       @pos<<row[2]
            end
	  end	
	end
    end

    @qq = @otd.sort!
      @otd.each do |otde|
      o = Otdel.find_by_name(otde)
      if o == nil
         o = Otdel.new( :name => otde)
         o.save
      end
    end

    @pos.sort!
    @pos.each do |po|
	p = Position.find_by_name(po)
  	if p == nil
           p = Position.new( :name => po)
           p.save
        end
    end
    #return

    o = nil
    p = nil
    CSV.foreach(params[:upload][:avatar].tempfile, :col_sep => ";") do |row|
	if row[1] == nil && row[2]!=nil
	  o = Otdel.find_by_name(row[2])
	  if o == nil
              o = Otdel.new( :name => row[2])
              o.save
          end
        else
          if row[2]!=nil 
	    p = Position.find_by_name(row[2])
  	    if p == nil
               p = Position.new( :name => row[2])
               p.save
            end
	  end
	     if o == nil 
                otdel_id = 0
	     else
		otdel_id = o.id
             end

	     if p == nil 
                p_id = 0
	     else
		p_id = p.id
             end	
          if row[1]!=nil
	   u = Phone.find_by_name(row[1])
	   if u == nil 
	     u = Phone.new( :name =>row[1], :otdel_id => otdel_id, :position_id => p_id, :number => row[3])
	     u.save 
		@data<<otdel_id
	   else 
             u.number = row[3]
             u.otdel_id = otdel_id
             u.position_id = p_id
             u.save
	   end
	 end 
	end
    end

  end


end

class OrderPdf < Prawn::Document
  def initialize(order, search, view)
    super(top_margin: 70)
    @orders = order
    @search = search
    @view = view
    date
    region
    order_number
    orders
#    orders2
end

  
  def order_number
      text "Total Orders: #{@orders.count}", size: 16, style: :bold
  end
  
  def region
    if @search.region_name_cont != nil
    text "Region: #{@search.region_name_cont}", size: 16, style: :bold
    end
  end
      
      def date 
        text "Date: #{@search.date_cont}", size: 16, style: :bold
      end

      
    def orders
      move_down 20
      table line_item_rows do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
      end
    end

      def line_item_rows
       [[ "Menu", "Cannon Street", "Regent", "Sub-Total", "Acton", "Total"]] +
       @orders.group_by{|x| x.menu_name }.map do |key,orders|
         
       [key, orders.select{|x| x.region_id == 3}.length,
         orders.select{|x| x.region_id == 1}.length,
         orders.select{|x| x.region_id == 3}.length + orders.select{|x| x.region_id == 1}.length,
         orders.select{|x| x.region_id == 2}.length, orders.length]
       end
      end
      
      
          def hello
              [[ "Menu", "Cannon Street", "Regent", "Sub-Total", "Acton", "Total"]] +
               @orders.group_by{|x| x.menu_name }.map do |key,orders|


                 orders.group_by{|x| x.region_name}.map do |rname,values|
                 end

               [Menu.name,      orders.length]
               end
             end
             
             
  
   #   def orders2
  #      move_down 20
 #       table line_item_rows2 do
#          row(0).font_style = :bold
    #      columns(1..3).align = :right
   #       self.row_colors = ["DDDDDD", "FFFFFF"]
  #        self.header = true
 #       end
#      end
      
      #def line_item_rows2
      #   [["Menu", "Employee", "Department", "Date"]] +
       #  @orders.order.map do |order|
      #     [order.menu_name, order.user_name, order.user.try(:department_name), order.date]
      #   end
      # end
       
  end
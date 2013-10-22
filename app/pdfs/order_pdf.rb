class OrderPdf < Prawn::Document
  def initialize(order, view)
    super(top_margin: 70)
    @orders = order
    @view = view
    date
    order_number
    orders
    orders2
end

  
  def order_number
      text "Total Orders: #{@orders.count}", size: 16, style: :bold
  end
  
  def params
    end
      
      def date 
        c=@orders.select("DISTINCT(date)"). map do |order|
        
        text "Date: #{order.date}", size: 16, style: :bold
      end
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
       [[ "Menu", "Total Orders"]] +
       @orders.group_by{|x| x.menu_id }.map do |key,orders|
       [Menu.find(key).try(:name),orders.length]
       end
      end
      
      def orders2
        move_down 20
        table line_item_rows2 do
          row(0).font_style = :bold
          columns(1..3).align = :right
          self.row_colors = ["DDDDDD", "FFFFFF"]
          self.header = true
        end
      end
      
      def line_item_rows2
         [["Menu", "Employee", "Department", "Date"]] +
         @orders.order.map do |order|
           [order.menu_name, order.user_name, order.user.try(:department_name), order.date]
         end
       end
       
  end
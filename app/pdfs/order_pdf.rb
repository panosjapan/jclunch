class OrderPdf < Prawn::Document
  def initialize(order, view)
    super(top_margin: 70)
    @orders = order
    @view = view
    order_number
    orders
    end
  
  def order_number
      text "Orders  ", size: 30, style: :bold
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
      [["Employee", "Menu", "Department", "Region", "Date"]] +
      @orders.order.map do |order|
        [order.user_name, order.menu_name, order.user.try(:department_name),  
          order.region_name, order.date]
      end
    end

  
  end
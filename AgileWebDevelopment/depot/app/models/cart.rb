class Cart < ActiveRecord::Base
    has_many :line_items, dependent: :destroy

    # when adding product to cart, either create a new line_item or 
    # increment the quantity if the product already has been added once
    def add_product(product_id)
        current_item = line_items.find_by(product_id: product_id)
        current_item = line_items.build(product_id: product_id) unless current_item
        
        current_item.quantity += 1 # default value is 0
        current_item.save
        current_item
    end

    def total_price
        line_items.to_a.sum {|item| item.total_price}
    end
end


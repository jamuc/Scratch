class CombineItemsInCart < ActiveRecord::Migration
  def up
        Cart.all.each do |cart|
            sums = cart.line_items.group(:product_id).count(:product_id)

            sums.each do |product_id, count|
                if count > 1
                    line_items = cart.line_items.where(product_id: product_id)
                    quantity = line_items.sum(:quantity)
                    line_items.delete_all

                    current_item = cart.line_items.build(product_id: product_id)
                    current_item.quantity = quantity 
                    current_item.save!
                end                
            end
        end
  end

  def down
        Cart.all.each do |cart|
            cart.line_items.each do |line_item|
                if line_item.quantity > 1
                    line_item.quantity.times do 
                        current_item = cart.line_items.build(product: line_item.product)
                        current_item.quantity = 1
                        current_item.save!
                    end

                    line_item.delete
                end
            end
        end
  end
end

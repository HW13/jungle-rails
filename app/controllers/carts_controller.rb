class CartsController < ApplicationController
  
  before_filter :authorize
  
  def show
  end

  def add_item
    product_id = params[:product_id].to_s
    product = Product.find(product_id)
    item_quantity = 0
    
    if cart[product_id]
      item_quantity = cart[product_id]["quantity"]
    end
    
    case  
      when product.quantity === 0  
        redirect_to :back, notice: "Sorry, #{product.name} is Currently out of Stock"
      when product.quantity - 1 < item_quantity 
        redirect_to :back, notice: "Sorry, #{product.name} has Limited Stock"
      else    
      item = cart[product_id] || { "quantity" => 0 }
      item["quantity"] += 1
      cart[product_id] = item
      update_cart cart

      redirect_to :back, notice: "#{product.name} Added to Cart"
    end
    
  end

  def remove_item
    product_id = params[:product_id].to_s
    product = Product.find(product_id)

    item = cart[product_id] || { "quantity" => 1 }
    item["quantity"] -= 1
    cart[product_id] = item
    cart.delete(product_id) if item["quantity"] < 1
    update_cart cart

    redirect_to :back, notice: "#{product.name} Removed from Cart"
  end

end

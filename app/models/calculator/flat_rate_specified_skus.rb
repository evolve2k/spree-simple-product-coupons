class Calculator::FlatRateSpecifiedSkus < Calculator
  preference :discount_amount,  :decimal, :default => 0
  preference :skus_ids, :string, :default => 0
  
  def self.description
    I18n.t("flat_rate_specified_skus")
  end

  def self.register
    super
    Coupon.register_calculator(self)
  end

  def compute(order)
    #Order is an array of all the items in the shopping cart
    total_discount = 0
    order.each do |line_item|
      sku_ids = self.preferred_skus_ids.split(",")
      sku_ids.each do |item|
        if line_item.variant.sku.upcase === item.upcase
          item_discount = [self.preferred_discount_amount,line_item.price].min # Max discount to the product price.
          total_discount += (item_discount * line_item.quantity)
        end
      end
    end
    return total_discount
  end
end

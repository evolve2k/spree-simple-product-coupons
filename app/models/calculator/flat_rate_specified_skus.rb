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
    sku_ids = self.preferred_skus_ids.split(",")
    order.each do |line_item|
      # Match either product or variant SKU
      line_item_sku = line_item.variant.sku.blank? ? line_item.product.sku : line_item.variant.sku
      # Only match once with find
      unless sku_ids.find{|sku| sku.upcase == line_item_sku.upcase}.nil?
        item_discount = [self.preferred_discount_amount, line_item.price].min # Max discount to the product price.
        total_discount += (item_discount * line_item.quantity)
      end
    end
    total_discount
  end
end

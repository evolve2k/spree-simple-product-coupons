class Calculator::FlatPercentageSpecifiedSkus < Calculator
  preference :percentage_discount,  :decimal, :default => 0
  preference :skus_ids, :string, :default => 0
  
  def self.description
    I18n.t("flat_percentage_specified_skus")
  end

  def self.register
    super
    Coupon.register_calculator(self)
  end

    def compute(order)
      #Order is an array of all the items in the shopping cart'      
      total_discount = 0
      discount_rate = [self.preferred_percentage_discount / 100 , 1].min  # Maximum 100% discount
      skus_ids = self.preferred_skus_ids.split(",")
      order.each do |line_item|
        # Match either product or variant SKU
        line_item_sku = line_item.variant.sku.blank? ? line_item.product.sku : line_item.variant.sku
        # Only match once with find
        unless skus_ids.find{|sku| sku.upcase == line_item_sku.upcase}.nil?
          total_discount += line_item.price * line_item.quantity * discount_rate
        end
      end
      total_discount
    end
  end
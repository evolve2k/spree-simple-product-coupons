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
      order.each do |line_item|
        skus_ids = self.preferred_skus_ids.split(",")
        skus_ids.each do |item|
          if item.upcase  === line_item.variant.sku.upcase
            total_discount += ((line_item.price * line_item.quantity) * discount_rate)
          end          
        end
      end
      total_discount
    end
  end
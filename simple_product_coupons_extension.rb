# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SimpleProductCouponsExtension < Spree::Extension
  version "1.0"
  description "Create simple coupons for the product variants you specify. (Includes Fixed Dollar and Percentage discounts)"
  url "http://github.com/evolve2k/spree-simple-product-coupons"

  # Please use product_coupons/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
    
    Calculator::FlatRateSpecifiedSkus.register
    Calculator::FlatPercentageSpecifiedSkus.register
  end
end

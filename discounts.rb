require 'byebug'

module Discounts
  module_function

  DISCOUNTS = JSON.parse(File.read('./config/discounts.json'))['discounts']

  def calculate(discount_type, items)
    case discount_type
    when :bulk_discount then bulk_discount(items)
    when :group_discount   then group_discount(items)
    else raise 'Unknown discount type'
    end
  end

  def bulk_discount(items)
    discounts = DISCOUNTS.select{ |discount| discount['type'] == 'bulk_discount'}
    discounts.inject(0) do |total, discount|
      valid_items = items.select{ |item| item == discount['product_code'] }
      valid_items.size >= discount['required_items'] ? valid_items.size*discount['discount'] : 0
    end
  end

  def group_discount(items)
    discounts = DISCOUNTS.select{ |discount| discount['type'] == 'group_discount'}
    discounts.inject(0) do |total, discount|
      valid_items = items.select{ |item| item == discount['product_code'] }

      valid_items.size >= discount['required_items'] ? (valid_items.size/3)*discount['discount'] : 0
    end
  end
end
require 'byebug'

module Discounts
  module_function

  DISCOUNTS = JSON.parse(File.read('./config/discounts.json'))['discounts']

  def calculate(discount_type, items)
    discounts = DISCOUNTS.select{ |discount| discount['type'] == discount_type.to_s }
    discounts.inject(0) do |total, discount|
      valid_items_count = items.select{ |item| item == discount['product_code'] }.size
      valid_items_count >= discount['required_items'] ? (valid_items_count/discount['group_size']) * discount['value'] : 0
    end
  end
end

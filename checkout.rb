require 'json'
require 'byebug'
require_relative 'discounts'

class Checkout
  PRODUCTS = JSON.parse(File.read('./config/products.json'))['products']

  attr_reader :discounts, :currency, :checkout

  def initialize(discounts: [], currency: '€')
    @discounts = discounts
    @currency  = currency
    @checkout = []
  end

  def scan(product_code)
    raise "Unknown product code: #{product_code}" unless valid_code?(product_code)
    checkout << product_code
  end

  def remove(product_code)
    raise "Unknown product code: #{product_code}" unless valid_code?(product_code)
    checkout.delete_at(checkout.index(product_code))
  end

  def total
    net_ammount - discount
  end

  private

  def net_ammount
    checkout.inject(0) do |total, product_code|
      total + PRODUCTS.find { |product| product['code'] == product_code }['price']
    end
  end

  def discount
    discounts.inject(0) { |total, discount| total + Discounts.calculate(discount, checkout) } || 0
  end

  def valid_code?(product_code)
    PRODUCTS.map{|product| product['code']}.include? product_code
  end
end

require 'spec_helper'
require_relative '../checkout'

describe Checkout do
  let(:items) { %w(VOUCHER TSHIRT VOUCHER VOUCHER MUG TSHIRT TSHIRT) }

  context 'when all the items are valid' do
    context 'and bulk_discount and two_for_one are active' do
      it 'calculates the total with discounts' do
        checkout = Checkout.new(discounts: [:bulk_discount, :group_discount])
        items.each { |item| checkout.scan(item) }
        expect(checkout.total).to eql(74.50)
      end
    end

    context 'and no discount is active' do
      it 'calculates the total without discounts' do
        checkout = Checkout.new()
        items.each { |item| checkout.scan(item) }
        expect(checkout.total).to eql(82.50)
      end
    end
  end

  context 'when an item is invalid' do
    it 'raises an error' do
      checkout = Checkout.new
      expect { checkout.scan('NEW_ITEM') }.to raise_error(ArgumentError)
    end
  end
end

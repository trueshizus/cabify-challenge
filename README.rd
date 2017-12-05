Cabify Coding Challenge
=======================

This an implementation for https://github.com/cabify/rubyChallenge

### Considerations

* I wasn't sure about the scope of the solution or what was actually expected. From the questions I sended trough email I assume this is enough but I wouldn't call it production ready for there are many ambiguities in the requirements.
* I assume the 2-for-1 discount only applies if the user buys 3 items, gets one for free. This could also be interpreted as buy two items and get one added on the checkout list.
* In the checkout process section it says `Checkout.new(pricing_rules)`. I assume `pricing_rules` allows a user to enable/disable discounts and to choose the currency.
* In the example section it says `Total: 32.50€`. I added a pretty_total to add the `€` sign.
* I added the `:remove` method but it wasn't part of the requirements
* Products and discounts are stored in a file, the solution does not have buisseness data in its source.
* The file discounts.json has the following structure:
```json
"discounts": [
    {
        "type": "group_discount",
        "product_code": "VOUCHER",
        "required_items": 3,      # Minimum number of items to apply the discount
        "group_size": 3,          # One item in 'group_size' will recive the discount. If group_size is equal to one, all items recive a discount.
        "value": 5.0              # Value to discount per valid item
    }
]
```

### Installing

To use the `Checkout` class make sure you have ruby and bundler installed. Then simply clone the repo and use it with irb.
```
  git clone https://github.com/JesusHerrera/cabify-challenge.git
  irb -r ./checkout.rb
```

### Configuration

To add new products edit `config/products.json`

To add new discounts edit `config/discounts.json`


### Runing Test

To run the tests simply run `rspec` in the root folder
```
rspec
```

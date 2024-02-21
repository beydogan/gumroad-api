## Products

#### Listing Products

```ruby
products = Gumroad::Product.list
```

#### Retrieving a Product

```ruby
product = Gumroad::Product.retrieve('product_id')
```

#### Deleting a Product

```ruby
Gumroad::Product.destroy('product_id')
```

#### Enabling a Product

```ruby
Gumroad::Product.enable('product_id')
```

#### Disabling a Product

```ruby
Gumroad::Product.disable('product_id')
```
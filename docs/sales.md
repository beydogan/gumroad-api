## Sales

#### Listing Sales

It returns a tuple with the sales and the next page key for pagination.
```ruby
sales, next_page = Gumroad::Sale.list

sales.each do |sale|
  sale.id # => 'sale_id'
  sale.product_id # => 'product_id'
end
```

You can also use the filters:

```ruby
sales, next_page = Gumroad::Sale.list(product_id: 'product_id', before: '2016-01-01', after: '2015-01-01')
```

You can also use the page_key to get the next page of sales:

```ruby
sales, next_page = Gumroad::Sale.list(page_key: next_page)
```

#### Retrieving a Sale

```ruby
sale = Gumroad::Sale.retrieve('sale_id')

sale.id # => 'sale_id'
sale.product_id # => 'product_id'
```

#### Marking a Sale as Shipped

```ruby
sale = Gumroad::Sale.mark_as_shipped('sale_id')

sale.success? # => true
```
or with tracking url
```ruby
sale = Gumroad::Sale.mark_as_shipped('sale_id', tracking_url: 'http://example.com/tracking')

sale.success? # => true
```

#### Refunding a Sale

```ruby
sale = Gumroad::Sale.refund('sale_id')

sale.success? # => true
```
or partial refund with `amount_cents`

```ruby
sale = Gumroad::Sale.refund('sale_id', amount_cents: 1000)

sale.partially_refunded # => true
```
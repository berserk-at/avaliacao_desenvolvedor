json.extract! sale, :id, :buyer_id, :product_id, :price, :amount, :supplier_id, :file, :created_at, :updated_at
json.url sale_url(sale, format: :json)

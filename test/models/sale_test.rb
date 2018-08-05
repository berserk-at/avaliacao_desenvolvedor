require 'csv'
require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  test "import sales" do
    file_upload = "sample_sales.txt"
    CSV.open(file_upload, "wb", headers: true, :col_sep => "\t") do |csv|
      csv << ["Comprador", "descrição", "Preço Unitário", "Quantidade", "Endereço", "Fornecedor"]
      csv << ["Buyer 1", "Description of Product 1", "10.0", "9", "Test Street 1", "Supplier 1"]
      csv << ["Buyer 2", "Description of Product 1", "10.0", "5", "Test Street 2", "Supplier 1"]
      csv << ["Buyer 1", "Description of Product 2", "20.0", "8", "Test Street 1", "Supplier 1"]
      csv << ["Buyer 3", "Description of Product 3", "30.0", "6", "Test Street 3", "Supplier 2"]
      csv << ["Buyer 2", "Description of Product 4", "40.0", "3", "Test Street 2", "Supplier 2"]
      
    end
    Sale.where(file: 'sample_sales.txt').destroy_all
    assert_difference 'Sale.count', 5 do
      assert_difference 'Buyer.count', 3 do
        assert_difference 'Product.count', 4 do
          assert_difference 'Supplier.count', 2 do
            Sale.import(Rack::Test::UploadedFile.new(file_upload, 'text/csv'))
          end
        end
      end
    end
  end
end

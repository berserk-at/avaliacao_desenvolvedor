require 'csv'
class Sale < ActiveRecord::Base
  def self.import(file_upload)
    if file_upload.present?
      Sale.where(file: file_upload.original_filename).destroy_all

      CSV.foreach(file_upload.path, headers: true, :col_sep => "\t") do |row|
        v_buyer=Buyer.where(name: row[0]).first;
        if v_buyer.nil?
          v_buyer=Buyer.create(name: row[0], address: row[4])
        end
        puts v_buyer.id
        v_product=Product.where(description: row[1]).first;
        if v_product.nil?
          v_product=Product.create(description: row[1], price: row[2])
        end
        v_supplier=Supplier.where(name: row[5]).first;
        if v_supplier.nil?
          v_supplier=Supplier.create(name: row[5])
        end
        puts v_supplier
        Sale.create!(buyer_id: v_buyer.id,
                     product_id: v_product.id,
                     price: row[2],
                     amount: row[3],
                     supplier_id: v_supplier.id,
                     file: file_upload.original_filename) 
      end
    end
  end
end

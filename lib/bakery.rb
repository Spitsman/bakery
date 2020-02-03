require 'yaml'
require_relative 'bin_packer'
require_relative 'product'

class Bakery
  ProductNotFoundError = Class.new(StandardError)
  PackError = Class.new(StandardError)

  def initialize(path = 'config/products.yml')
    @products = YAML.load_file(path)
    @packer = BinPacker.new
  end

  def pack(items_count, code)
    product = find_product(code)
    result = @packer.call(items_count, product.packs_counts)

    raise(PackError, "Unable to create pack of #{items_count} items for #{product.name}") if result.empty?

    number_per_pack(result, product)
  end

  private

  def number_per_pack(result, product)
    result.map do |ary|
      ary.each_with_object({}) do |(count, number_of_packs), hash|
        pack = product.find_pack('count', count)
        hash[pack] = number_of_packs
      end
    end
  end

  def find_product(code)
    product_hash = @products.find { |product| product['code'] == code }
    
    raise(ProductNotFoundError, 'Product not found') if product_hash.nil?

    Product.new(name: product_hash['name'], code: product_hash['code'], packs: product_hash['packs'])
  end
end

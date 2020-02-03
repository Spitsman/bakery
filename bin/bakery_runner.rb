require 'optparse'
require_relative '../lib/bakery'
require_relative '../lib/parser'

bakery = Bakery.new

def print(packs_ary)
  packs_ary.each do |packs_hash|
    total_price = packs_hash.inject(0) { |sum, (k, v)| sum + k['price'] * v }
    str = packs_hash.map do |pack, number|
      "#{pack['count']}-pack ($#{pack['price']}) x #{number}"
    end.join(', ')
    str << ". Total price: $#{total_price}"
    puts str
  end
end

ARGF.each do |line|
  begin
    print(bakery.pack(*Parser.call(line)))
  rescue StandardError => e
    puts e
  rescue
    puts 'Internal error'
  end
end

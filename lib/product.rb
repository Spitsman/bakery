class Product
  attr_reader :name, :code, :packs

  def initialize(name:, code:, packs:)
    @name = name; @code = code; @packs = packs
  end

  def packs_counts
    packs.map { |pack| pack['count'] }
  end

  def find_pack(attribute, value)
    packs.find { |pack| pack[attribute.to_s] == value }
  end
end

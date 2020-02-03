 class BinPacker
  def call(items_count, item_packs)
    combinations = build_combinations(item_packs)
    pack_counts = combinations.map { |combination| pack_combination(items_count, combination) }.compact
    filtered_packs_counts = select_min_packs(pack_counts)
    group_packs_by_count(filtered_packs_counts)
  end

  private

  def pack_combination(items_count, combination)
    out = []
    rest = items_count

    while rest > 0
      max = combination.max
      break if max.nil?

      if rest - max >= 0
        out << max
        rest -= max
      else
        combination.delete(max)
      end
    end

    return unless out.inject(0, :+) == items_count

    out
  end

  def build_combinations(item_packs)
    combinations = []
    item_packs.length.times { |i| combinations += item_packs.combination(i + 1).to_a }
    combinations
  end

   def select_min_packs(ary)
     min_length = ary.map(&:length).min
     ary.select { |r| r.length == min_length }
   end

   def group_packs_by_count(ary)
     ary.map { |h| h.each_with_object({}) { |n, hsh| hsh[n] = hsh[n] ? hsh[n] + 1 : 1 } }.uniq
   end
end

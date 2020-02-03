class Parser
  WrongInputError = Class.new(StandardError)

	def self.call(line)
    items_count, code = line.split(' ')

    raise(WrongInputError, 'Wrong input') unless items_count && items_count.match(/^\d+$/) && code

    [items_count.to_i, code]
  end
end
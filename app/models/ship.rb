class Ship
  attr_accessor :name, :size, :pos, :direction

  def initialize(name, size)
    @name = name
    @size = size
  end

  def record(x, y, direction)
    # not sure about this, revisit once attacks start
  end
end
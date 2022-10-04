class Ship
  attr_accessor :name, :size, :pos, :direction

  def initialize(name, size)
    @name = name
    @size = size
  end
end
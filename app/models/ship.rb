class Ship
  attr_accessor :name, :size, :health

  def initialize(name, size)
    @name = name
    @size = size
    @health = size
  end
end
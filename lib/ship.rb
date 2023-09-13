class Ship
  attr_reader :name, :length
  attr_accessor :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @sunk = false
    @health = 0
    assign_health
  end

  def assign_health
    @health = @length
  end

  def sunk?
    if @health == 0
      @sunk = true
    end
  end

  def hit
    @health -= 1
    sunk?
  end
end
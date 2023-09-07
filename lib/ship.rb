class Ship
  attr_reader :name, :length, :sunk, :health
  attr_accessor :health

  def initialize(name, length, sunk = false)
    @name = name
    @length = length
    @sunk = sunk
    @health = health
    assign_health
  end

  def assign_health
    @length = @health
  end

  def sunk?
    if @health == 0
      @sunk = true
    else
      @sunk = false
  end

  def hit
    @health -= 1
  end

end
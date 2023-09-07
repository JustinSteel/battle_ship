class Ship
  attr_reader :name, :length, :sunk, :health
  attr_accessor :health

  def initialize(name, length, sunk = false)
    @name = name
    @length = length
    @sunk = sunk
    @health = 0
    assign_health
  end

  def assign_health
    @health = @length
  end

  def sunk?
    if @health == 0
      @sunk = true
    else
      @sunk = false
    end
  end

  def hit
    @health -= 1
  end

end
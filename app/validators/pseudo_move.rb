class PseudoMove
  attr_reader :variety, :x, :y, :player
  attr_accessor :errors

  def initialize(**kwargs)
    @variety = kwargs[:variety]
    @x = kwargs[:x]
    @y = kwargs[:y]
    @player = kwargs[:player]
    @errors = { base: [] }
  end

  def to_coords
    { x: x, y: y }
  end

  def valid?
    errors == { base: [] }
  end
end

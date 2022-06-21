
class BasicGame
  # Makes "args" attribute available within the class -> http://docs.dragonruby.org/#----attr_gtk-rb
  attr_gtk

  def tick
    defaults
    render
  end

  protected

    def defaults
      state.cubes   ||= [cube]
    end

    def render
      outputs.solids << state.cubes.map do |c|
        [c[:x], c[:y], c[:w], c[:h]]
      end
    end

  private

    def cube
      {
        x: 1280 * rand,
        y: 720 * rand,
        w: 35,
        h: 35
      }
    end
end

# This method is called by DragonRuby every frame
def tick(args)
  $game ||= BasicGame.new
  $game.args = args
  $game.tick
end

$gtk.reset
$game = nil

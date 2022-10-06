class BasicGame
  # Makes "args" attribute available within the class -> http://docs.dragonruby.org/#----attr_gtk-rb
  attr_gtk


  def tick
    defaults
    render
    move_cube
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

    def move_cube
      # move on y axis
      if inputs.up
        state.cubes.first.y += DISTANCE_TO_MOVE
      elsif inputs.down
        state.cubes.first.y -= DISTANCE_TO_MOVE
      end

      # move on x axis
      if inputs.left
        state.cubes.first.x -= DISTANCE_TO_MOVE
      elsif inputs.right
        state.cubes.first.x += DISTANCE_TO_MOVE
      end
    end

  private

    DISTANCE_TO_MOVE = 10

    PLAYABLE_AREA = {
      :width  => 1280,
      :height => 720
    }

    def cube
      {
        x: PLAYABLE_AREA[:width] * rand,
        y: PLAYABLE_AREA[:height] * rand,
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
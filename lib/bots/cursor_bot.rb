require 'bots/bot'

class CursorBot < BattleBots::Bots::Bot
  IDEAL_MIN = 280
  IDEAL_MAX = 480

  def initialize
    @name = 'DW: CursorBot'
    @strength = 32
    @speed = 48
    @stamina = 28
    @sight = 42
  end

  def self.bot_source
    :ai
  end

  def think
    enemy = select_target
    unless enemy
      stand_by
      return
    end

    bearing, distance = calculate_vector_to(enemy)
    aim_turret(bearing, distance)

    if distance > IDEAL_MAX
      close_the_enemy(bearing, distance)
    elsif distance < IDEAL_MIN
      run_away(bearing, distance)
    else
      @drive = 0.35
      orbit = (bearing + 90) % 360
      @turn = (@heading - orbit) % 360 > 180 ? 1 : -1
    end
  end
end

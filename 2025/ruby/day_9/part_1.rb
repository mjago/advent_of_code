require "colorize"

puts "\n\n.   .   start   .   .".colorize(mode: :bold, color: :white)

class Part1

  INPUT = '2025/ruby/day_9/real.txt'

  def initialize
    @data = []
    @grid = []
    @x_max = find_x_max
    @y_max = find_y_max
    read_input
    parse_squares
  end

  def read_input
    File.open(INPUT, 'r') do |f|
      lines = f.readlines
      lines.each do |line|
        @data << line
      end
    end
  end

  def parse_squares
    @red_pos = []
    (0...@data.size).each do |idx|
      @red_pos << parse_tile(idx)
    end
  end

  def parse_xy(idx)
    line = @data[idx]
    i = line.index(',')
    x = line[0...i].to_i
    y = line[i+1..-1].to_i
    [x, y]
  end

  def parse_tile(idx)
    x, y = parse_xy(idx)
    [x, y]
  end

  def find_x_max
    x_max = 0
    (0...@data.size).each do |idx|
      x, y = parse_tile(idx)
      x_max = x if(x > x_max)
    end
    x_max
  end

  def find_y_max
    y_max = 0
    (0...@data.size).each do |idx|
      x, y = parse_tile(idx)
      y_max = y if(y > y_max)
    end
    y_max
  end

  def calc_area(pos0, pos1)
    x0, x1 = @red_pos[pos0][0], @red_pos[pos1][0]
    y0, y1 = @red_pos[pos0][1], @red_pos[pos1][1]
    x = (x0 - x1).abs + 1
    y = (y0 - y1).abs + 1
    area = x * y
    @max_area = area if(area > @max_area)
  end

  def run
    sleep 1
    @max_area = 0
    (0...@red_pos.size).each do |pos0|
      ((pos0 + 1)...@red_pos.size).each do |pos1|
        if pos0 != pos1
          calc_area pos0, pos1
        end
      end
    end
    @max_area
  end
end


@total = Part1.new.run

puts "Total: #{@total}".colorize(mode: :bold, color: :red)

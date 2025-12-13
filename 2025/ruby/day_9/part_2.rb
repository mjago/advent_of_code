require "colorize"
require "set"

class Part2
#  INPUT = '2025/ruby/day_9/sample.txt'
  INPUT = '2025/ruby/day_9/real.txt'

  def initialize
    @data = []
    @total = 0
    read_input
  end

  def read_input
    File.open(INPUT, 'r') do |f|
      lines = f.readlines
      lines.each do |line|
        @data << line
      end
    end
  end

  def run
    points = []
    @data.each do |line|
      x, y = line.strip.split(",").map!(&:to_i)
      points << [x, y]
    end
    xs = points.map { |x, _y| x }.uniq.sort
    ys = points.map { |_x, y| y }.uniq.sort

    grid_width  = xs.length * 2 - 1
    grid_height = ys.length * 2 - 1

    grid = Array.new(grid_width) { Array.new(grid_height, 0) }

    points.zip(points[1..] + [points[0]]) do |(x1, y1), (x2, y2)|
      cx1, cx2 = [xs.index(x1) * 2, xs.index(x2) * 2].sort
      cy1, cy2 = [ys.index(y1) * 2, ys.index(y2) * 2].sort

      (cx1..cx2).each do |cx|
        (cy1..cy2).each do |cy|
          grid[cx][cy] = 1
        end
      end
    end

    outside = Set.new([[-1, -1]])
    queue   = outside.to_a.dup

    until queue.empty?
      tx, ty = queue.shift
      [[tx - 1, ty], [tx + 1, ty], [tx, ty - 1], [tx, ty + 1]].each do |nx, ny|

        next if nx < -1 ||
                ny < -1 ||
                nx > grid_width ||
                ny > grid_height

        next if 0 <= nx &&
                nx < grid_width &&
                0 <= ny &&
                ny < grid_height &&
                grid[nx][ny] == 1

        next if outside.include?([nx, ny])

        outside.add([nx, ny])
        queue << [nx, ny]
      end
    end

    (0...grid_width).each do |x|
      (0...grid_height).each do |y|
        grid[x][y] = 1 unless outside.include?([x, y])
      end
    end

    psa = Array.new(grid_width) { Array.new(grid_height, 0) }

    (0...grid_width).each do |x|
      (0...grid_height).each do |y|
        left    = (x > 0) ? psa[x - 1][y] : 0
        top     = (y > 0) ? psa[x][y - 1] : 0
        topleft = (x > 0 && y > 0) ? psa[x - 1][y - 1] : 0
        psa[x][y] = left + top - topleft + grid[x][y]
      end
    end

    valid = lambda do |x1, y1, x2, y2|
      cx1, cx2 = [xs.index(x1) * 2, xs.index(x2) * 2].sort
      cy1, cy2 = [ys.index(y1) * 2, ys.index(y2) * 2].sort

      left    = (cx1 > 0) ? psa[cx1 - 1][cy2] : 0
      top     = (cy1 > 0) ? psa[cx2][cy1 - 1] : 0
      topleft = (cx1 > 0 && cy1 > 0) ? psa[cx1 - 1][cy1 - 1] : 0

      count = psa[cx2][cy2] - left - top + topleft
      count == (cx2 - cx1 + 1) * (cy2 - cy1 + 1)
    end

    max_area = 0

    points.each_with_index do |(x1, y1), i|
      points[0...i].each do |x2, y2|
        next unless valid.call(x1, y1, x2, y2)
        area = (x1 - x2).abs.succ * (y1 - y2).abs.succ
        max_area = area if area > max_area
      end
    end

    max_area
  end
end

total = Part2.new.run

puts "Total: #{total}".colorize(mode: :bold, color: :red)

# 1501292304

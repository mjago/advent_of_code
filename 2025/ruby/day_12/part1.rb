require "colorize"

class Part1

#  INPUT = '2025/ruby/day_12/sample.txt'
  INPUT = '2025/ruby/day_12/real.txt'

  def initialize
    @data = []
    @lists = []
    @data_end = -1
    @shape_number = -1
    @sizes = []
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

  def find_shape line
    regex = /(\d+):\n/
    m = line.match(regex)
    m[1] if m
  end

  def draw_shape(shape_number)
    puts "draw shape #{shape_number}"
    @shapes[shape_number].each do |line|
      puts line.strip.cyan
    end
  end

  def parse_list
    @data.each_with_index do |line, idx|
      result = nil
      if m = line.strip.match(/\A(\d+)x(\d+):\s*(.*)\z/)
        @data_end = idx if(@data_end == -1)
        rows = m[1].to_i          # 6
        cols = m[2].to_i          # 7
        rest = m[3].split.map(&:to_i)
        result = [rows, cols, *rest]
        puts result.to_s.red
        @lists << result
      end
    end
  end

  def parse_shapes
    @shapes = []
    (0...@data_end).each do |idx|
      line = @data[idx]
      number = find_shape(line)
      if number
        shape_number = number.to_i
        @shape_number += 1
        if shape_number != @shape_number
          raise "❌ Error: expected shape number #{@shape_number.inspect}, got #{shape_number.inspect}"
        end
        if @shape_number >= 1
     #     draw_shape (@shape_number - 1)
        end
        @shapes[@shape_number] = []
      else
        @shapes[@shape_number] << line
      end
    end
  end

  def calc_sizes
    @shapes.each do |shape|
      p shape
      size = 0
      shape.each do |line|
        p line.strip
        size += line.strip.gsub('.', '').size
      end
      p @sizes << size
    end
  end

  def calc_list_size
    @lists.each do |list|
      combined = 0
      total = list[0] * list[1]
      combined += @sizes[0] * list[2]
      combined += @sizes[1] * list[3]
      combined += @sizes[2] * list[4]
      combined += @sizes[3] * list[5]
      combined += @sizes[4] * list[6]
      combined += @sizes[5] * list[7]
      @total += 1 if(total - combined > 200)
      puts "total size #{total}, combined size #{combined}"
      puts "@total: #{@total}"
    end
  end

  def run
    parse_list
    parse_shapes
    calc_sizes
    calc_list_size
  end
end

Part1.new.run

# 462 too low
# 1968 too high
# 538

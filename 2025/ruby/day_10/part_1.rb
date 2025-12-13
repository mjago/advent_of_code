require "colorize"
require "set"

puts "\n\n.   .   start   .   .".colorize(mode: :bold, color: :white)

class Part1

#  INPUT = '2025/ruby/day_10/sample.txt'
  INPUT = '2025/ruby/day_10/real.txt'

  def initialize
    @data = ""
    @total = 0
    read_input
  end

  def read_input
    File.open(INPUT, 'r') do |f|
      lines = f.readlines
      lines.each do |line|
        @data += line
      end
    end
  end

  def process_line(line)
    line = line.strip
    rex = /^\[([.#]+)\] ([()\d, ]+) \{([\d,]+)\}$/
    m = line.match(rex)
    return unless m
    target_str, buttons_str, _ = m.captures
    target = target_str.chars.each_index.select { |i| target_str[i] == "#" }.to_set
    buttons = buttons_str.split.map do |button|
      inner = button[1..-2]
      inner.split(",").map!(&:to_i).to_set
    end

    (1..buttons.length).each do |count|
      buttons.combination(count) do |attempt|
        lights = Set.new
        attempt.each do |button_set|
          lights ^= button_set
        end

        if lights == target
          @total += count
          return
        end
      end
    end
  end

  def run
    @data.each_line do |line|
      process_line(line)
    end

    @total
  end
end

total = Part1.new.run

puts "Total: #{total}".colorize(mode: :bold, color: :red)

# 404

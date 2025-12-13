require "colorize"

puts "\n\n.   .   start   .   .".colorize(mode: :bold, color: :white)

class Part1

#  INPUT = '2025/ruby/day_11/sample.txt'
  INPUT = '2025/ruby/day_11/real.txt'

  def initialize
    @graph = Hash.new
    @data = ""
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

  def process line
    src, dest = line.strip.split(': ')
    @graph[src] = dest.split
  end

  def connect(src, dest)
    if src == dest
      return 1
    else
      @graph.fetch(src, []).sum do |x|
        connect(x, dest)
      end
    end
  end

  def run
    @data.each_line do |line|
      process line
    end

    connect('you', 'out')
  end
end

total = Part1.new.run

puts "Total: #{total}".colorize(mode: :bold, color: :red)

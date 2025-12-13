require 'colorize'

puts "\n\n.   .   start   .   .".colorize(mode: :bold, color: :white)

class Part2

#  INPUT = '2025/ruby/day_11/sample2.txt'
  INPUT = '2025/ruby/day_11/real2.txt'
 
  def initialize
    @graph = {}
    @data  = ''
    @memo  = {}
    read_input
  end

  def read_input
    File.open(INPUT, 'r') do |f|
      f.each_line { |line| @data << line }
    end
  end

  def process(line)
    src, dest = line.strip.split(': ')
    @graph[src] = dest.split
  end

  def connect(src, dest)
    # memoization key: pair of src and dest
    key = [src, dest]
    return @memo[key] if @memo.key?(key)

    result =
      if src == dest
        1
      else
        @graph.fetch(src, []).sum do |x|
          connect(x, dest)
        end
      end

    @memo[key] = result
  end

  def run
    @data.each_line { |line| process(line) }
    connect('svr', 'dac') *
      connect('dac', 'fft') *
      connect('fft', 'out') +
      connect('svr', 'fft') *
      connect('fft', 'dac') *
      connect('dac', 'out')
  end
end

total = Part2.new.run

puts "Total: #{total}".colorize(mode: :bold, color: :red)

require "colorize"
require "set"
require "z3"

puts "\n\n.   .   start   .   .".colorize(mode: :bold, color: :white)

class Part2

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

    _target_str, buttons_str, joltages_str = m.captures

    buttons = buttons_str.split.map do |button|
      inner = button[1..-2]
      inner.split(",").map!(&:to_i).to_set
    end

    joltages = joltages_str.split(",").map!(&:to_i)
    solver = Z3::Optimize.new

    vars = buttons.each_index.map do |i|
      Z3.Int("n#{i}") 
    end

    vars.each do |v|
      solver.assert(v >= 0)
    end

    joltages.each_with_index do |joltage, i|
      eq = 0
      buttons.each_with_index do |button, b|
        eq = eq + vars[b] if button.include?(i)
      end
      solver.assert(eq == joltage)
    end

    sum_vars = vars.reduce(0, :+) # 0 + v1 + v2 + ...
    solver.minimize(sum_vars)

    if solver.satisfiable?
      model = solver.model
      value = model[sum_vars]   # or: model.get_interp(sum_vars)
      @total += value.to_i
    end
  end

  def run
    @data.each_line do |line|
      process_line(line)
    end

    @total
  end
end

total = Part2.new.run

puts "Total: #{total}".colorize(mode: :bold, color: :red)

puts total

# 16474

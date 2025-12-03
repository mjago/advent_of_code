require "colorize"


puts "\n\n.   .   start   .   .".colorize(mode: :bold, color: :white)


#    11-22 has two invalid IDs, 11 and 22.
#    95-115 has one invalid ID, 99.
#    998-1012 has one invalid ID, 1010.
#    1188511880-1188511890 has one invalid ID, 1188511885.
#    222220-222224 has one invalid ID, 222222.
#    1698522-1698528 contains no invalid IDs.
#    446443-446449 has one invalid ID, 446446.
#    38593856-38593862 has one invalid ID, 38593859.
#    The rest of the ranges contain no invalid IDs.


@data0 = [
"11-22",
"95-115",
"998-1012",
"1188511880-1188511890",
"222220-222224",
"1698522-1698528",
"446443-446449",
"38593856-38593862",
"565653-565659",
"824824821-824824827",
"2121212118-2121212124"
]

@data1 = [
  "194-253",
  "81430782-81451118",
  "7709443-7841298",
  "28377-38007",
  "6841236050-6841305978",
  "2222204551-2222236166",
  "2623-4197",
  "318169-385942",
  "9827-16119",
  "580816-616131",
  "646982-683917",
  "147-181",
  "90-120",
  "3545483464-3545590623",
  "4304-5747",
  "246071-314284",
  "8484833630-8484865127",
  "743942-795868",
  "42-53",
  "1435-2086",
  "50480-60875",
  "16232012-16441905",
  "94275676-94433683",
  "61509567-61686956",
  "3872051-4002614",
  "6918792899-6918944930",
  "77312-106847",
  "282-387",
  "829099-1016957",
  "288251787-288311732",
  "6271381-6313272",
  "9877430-10095488",
  "59-87",
  "161112-224439",
  "851833788-851871307",
  "6638265-6688423",
  "434-624",
  "1-20",
  "26-40",
  "6700-9791",
  "990-1307",
  "73673424-73819233"
]

@matches = 0
@total   = 0

def find_pt1(id0, id1)
  id_int0 = id0.to_i
  id_int1 = id1.to_i

  id_int0.upto(id_int1) do |i|
    is = i.to_s
    size = is.size
    if size.even?
      half = size / 2
      if is[0...half] == is[half.. -1]
        puts "found match #{is}".colorize(mode: :bold, color: :green)
        @matches += 1
        @total += i
      end
    end
  end
end

def find_pt2(id0, id1)
  id_int0 = id0.to_i
  id_int1 = id1.to_i

  id_int0.upto(id_int1) do |i|
    is = i.to_s
    size = is.size
    half = (size / 2)
    1.upto(half) do |j|
      if size % j == 0
        if is[0...j] * (size / j) == is
          puts "found match #{is}".colorize(mode: :bold, color: :green)
          @matches += 1
          @total += i
          break
        end
      end
    end
  end
end

def run
  @data1.each do |dat|
    id_0 = dat[0..dat.index('-') - 1]
    id_1 = dat[dat.index('-') + 1.. -1]

    # find_pt1 id_0, id_1
    find_pt2 id_0, id_1
  end
end

run
puts "Total @Matches: #{@matches}".colorize(mode: :bold, color: :red)
puts "Total: #{@total}".colorize(mode: :bold, color: :red)

#33832678380

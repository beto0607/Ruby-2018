class AverageNumber
    @count
    @sum

    def initialize
        @count = 0
        @sum = 0
    end

    def avg
        @count > 0 ? @sum / @count : Float::NAN
    end

    def sum (value)
        @count += 1
        @sum += value
    end
end


class AverageInTime
    @avgs

    def initialize
        @avgs = Hash.new(AverageNumber)
    end

    def increment(to, value)
        @avgs[to].sum(value)
    end

    def value(from)
        @avgs[from].avg
    end
    def to_s(unit="ºC")
        @avgs.reduce("") {|str, (k.v) str + "#{k} has: #{v.avg}#{unit}\n"}
    end
end

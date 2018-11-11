class ExtremeDay
    @temp
    @day
    @operator

    attr_reader :day, :temp

    def initialize (operator = :<)
        @operator = operator
        @day = @temp = Float::NAN
    end

    def check(_temp, _day)
        if(@temp.send(@operator, _temp))then
            @temp = _temp
            @day = _day
        end
    end
end


class ExtremeDayInTime
    @hash

    def initialize(operator)
        @hash = Hash.new(ExtremeDay.new(operator))
    end

    def check(to, temp, day)
        @hash[to].check(temp, day)
    end

    def temp(from)
        @hash[from].temp
    end

    def day(from)
        @hash[from].day
    end
    def to_s(unit="ºC")
        @hash.reduce("") {|str, (k.v) str + "#{k} has: #{v.avg}#{unit}\n"}
    end
end

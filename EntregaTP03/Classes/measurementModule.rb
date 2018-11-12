module Measurement
end
class Hash
    include Measurement
    def self.createWithClass(className)
        Hash.new  {|h,k| h[k] = Object.const_get(className).new}
    end
    def self.createWithClassWithArgs(className, *args)
        Hash.new  {|h,k| h[k] = Object.const_get(className).new(*args)}
    end
    def inform(unit="", method_name=:avg)
        self.reduce("") {|str, (k, v)| str + "#{k} has: #{v.send(method_name)}#{unit}\n"}
    end
end
module Measurement
#---------------------Extreme-Day(Coldes-or-Hotest)------------------
    class ExtremeDay
        @temp
        @day
        @operator
        attr_reader :day, :temp
        def initialize (operator = :<)
            @operator = operator
            @day = @temp = nil
        end
        def checkTempTo(_temp, _day)
            if(nil == @temp)then
                @temp = _temp
                @day = _day
            end
            if(_temp.send(@operator, @temp))then
                @temp = _temp
                @day = _day
            end
        end
    end
    class ExtremeDayInTime
        @hash
        def initialize(operator)
            @hash = Hash.createWithClassWithArgs('Measurement::ExtremeDay', operator)
        end
        def checkTempTo(to, _temp, _day)
            (@hash[to]).checkTempTo(_temp, _day)
        end
        def temp(from)
            @hash[from].temp
        end
        def day(from)
            @hash[from].day
        end
        def to_s()
            @hash.inform("", :day)
        end
    end
#-------------------END-Extreme-Day(Coldes or Hotest)----------------
#-------------------------Average-Number-----------------------------
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
        @unit="ºC"
        attr_writer :unit
        def initialize
            @unit="ºC"
            @avgs = Hash.createWithClass 'Measurement::AverageNumber'
        end
    
        def increment(to, value)
            @avgs[to].sum(value)
        end
    
        def value(from)
            @avgs[from].avg
        end
        def to_s()
            @avgs.inform(@unit, :avg)
        end
    end
#-------------------------END-Average-Number-------------------------
#--------------------------Thermal-Amplitude-------------------------
    class ThermalAmplitude
        @min
        @max
        attr_reader :min, :max
        def initialize
            @min = @max = Float::NAN
        end

        def verify (value)
            @min = @min == Float::NAN ? value : minValue(@min, value)
            @max = @max == Float::NAN ? value : maxValue(@max, value)
        end
        
        def minValue(a, b)
            return a < b ? a : b
        end

        def maxValue(a, b)
            return a > b ? a : b
        end
        def to_s
            (@max - @min).to_s
        end
        private :minValue, :maxValue
    end

    class ThermalAmplitudeInTime
        @hash
        @unit
        attr_writer :unit
        def initialize
            @unit ="ºC"
            @hash = Hash.createWithClass 'Measurement::ThermalAmplitude'
        end

        def add(to, value)
            @hash[to].verify(value)
        end

        def min(from)
            @hash[from].min
        end

        def max(from)
            @hash[from].max
        end
        def to_s()
            @hash.inform(@unit, :to_s)
        end
    end 
#------------------------END-Thermal-Amplitude-----------------------

end
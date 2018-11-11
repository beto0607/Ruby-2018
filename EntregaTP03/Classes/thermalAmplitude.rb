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
        return a > b ? a :b
    end
    
    private :minValue, :maxValue
end

class ThermalAmplitudeInTime
    @hash

    def initialize
        @hash = Hash.new(ThermalAmplitude)
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
end
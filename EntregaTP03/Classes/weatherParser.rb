require_relative 'measurementModule'
require 'csv'


class WeatherParser
    include Measurement
    @dailyTempAVG
    @monthlyTempAVG
    @dailyTempAVGTS
    @monthlyTempAVGTS

    @dailyThermalAmplitude
    @dailyThermalAmplitudeTS

    @coldestDay
    @hotestDay
    @coldestDayTS
    @hotestDayTS

    @precipitationsAVG

    @instrumentFailure

    @lineCounter

    def initialize
        @monthlyTempAVG             = AverageInTime.new
        @monthlyTempAVG.unit        = "ºC"
        @dailyTempAVG               = AverageInTime.new
        @dailyTempAVG.unit          = "ºC"
        @dailyTempAVGTS             = AverageInTime.new
        @dailyTempAVGTS.unit        = "ºC"
        @monthlyTempAVGTS           = AverageInTime.new
        @monthlyTempAVGTS.unit      = "ºC"

        @dailyThermalAmplitude      = ThermalAmplitudeInTime.new
        @dailyThermalAmplitudeTS    = ThermalAmplitudeInTime.new

        @coldestDay                 = ExtremeDayInTime.new(:<)
        @hotestDay                  = ExtremeDayInTime.new(:>)
        @coldestDayTS               = ExtremeDayInTime.new(:<)
        @hotestDayTS                = ExtremeDayInTime.new(:>)

        @precipitationsAVG          = AverageInTime.new
        @precipitationsAVG.unit     = ""

        @instrumentFailure          = Hash.new  #key-> Instrument's name; value-> fails counter
        @instrumentFailure.default  = 0 #Hash.new (0) didn't work
        @lineCounter                = 0
    end
    def readFiles(*files)
        files.each do |f|
            readFile(f)
        end
    end
    def readFile(file)
        CSV.foreach(file, headers:true) do |row|
            parseRow(row)
        end
    end
    def parseRow(row)
        time= Time.new(row[0], row[1], row[2], row[3], row[4], 0, "-03:00")
        @lineCounter += 1
        parseTemperature(time, row[5])
        parseThermalSensation(time, row[6])
        parsePrecipitations(time, row[7])
        parseHumidity(time, row[8])
    end
    def showAllInfo()
        puts "Daily temperature:\n #{self.dailyTemperature}"
        puts "Daily thermal sensation:\n #{self.dailyThermalSensation}"
        puts "Monthly temperature:\n #{self.monthlyTemperature}"
        puts "Monthly thermal sensation:\n #{self.monthlyThermalSensation}"
        puts "Daily thermal amplitude:\n #{self.dailyThermalAmplitude}"
        puts "Daily thermal sensation amplitude:\n #{self.dailyThermalSensationAmplitude}"
        puts "Coldest day:\n #{self.coldestDay}"
        puts "Hotest day:\n #{self.hotestDay}"
        puts "Thermal sensation coldest day:\n #{self.thermalSensationColdestDay}"
        puts "Thermal sensation hotest day:\n #{self.thermalSensationHotestDay}"
        puts "Monthly precipitation average:\n #{self.precipitationAverage}"
        puts "Instrument failures:\n #{self.instrumentFailure}"
        puts "Worst intrument:\n #{self.worstInstrument[0]}"
    end
    def dailyTemperature()
        @dailyTempAVG.to_s
    end
    def dailyThermalSensation()
        @dailyTempAVGTS.to_s
    end
    def monthlyTemperature()
        @dailyTempAVG.to_s
    end
    def monthlyThermalSensation()
        @dailyTempAVGTS.to_s
    end
    def dailyThermalAmplitude
        @dailyThermalAmplitude.to_s
    end
    def dailyThermalSensationAmplitude
        @dailyThermalAmplitudeTS.to_s
    end
    def coldestDay
        @coldestDay.to_s
    end
    def thermalSensationColdestDay
        @coldestDayTS.to_s
    end
    def hotestDay
        @hotestDay.to_s
    end
    def thermalSensationHotestDay
        @hotestDayTS.to_s
    end
    def precipitationAverage
        @precipitationsAVG.to_s
    end
    def instrumentFailure
        @instrumentFailure.reduce("") {|str, (k,v)| str + "Intrument #{k} has: #{ v / @lineCounter}\n"}
    end
    def worstInstrument
        h.max_by{|k,v| v}
    end
    private
    def parseTemperature(time,temperature)
        begin
            temp = Float(temperature)
            @monthlyTempAVG.increment("#{time.year}/#{time.month}", temp)
            @dailyTempAVG.increment("#{time.year}/#{time.month}/#{time.day}", temp)
            
            @coldestDay.check("#{time.year}/#{time.month}", temp, time.day)
            @hotestDay.check("#{time.year}/#{time.month}", temp, time.day)

            @dailyThermalAmplitude.add("#{time.year}/#{time.month}/#{time.day}", temp)
        rescue ArgumentError
            @instrumentFailure["thermometer"] += 1
        end
    end
    def parseThermalSensation(time, thermal_sensation)
        begin
            temp = Float(thermal_sensation)
            @monthlyTempAVGTS.increment("#{time.year}/#{time.month}", temp)
            @dailyTempAVGTS.increment("#{time.year}/#{time.month}/#{time.day}", temp)
            
            @coldestDayTS.check("#{time.year}/#{time.month}", temp, time.day)
            @hotestDayTS.check("#{time.year}/#{time.month}", temp, time.day)

            @dailyThermalAmplitudeTS.add("#{time.year}/#{time.month}/#{time.day}", temp)
        rescue ArgumentError
            @instrumentFailure["thermal_sensation"] += 1
        end
    end
    def parsePrecipitations(time, precipitations)
        begin
            @precipitationsAVG.increment("#{time.year}/#{time.month}", Float(precipitations))
        rescue ArgumentError
            @instrumentFailure["pluviometer"] += 1
        end
    end
    def parseHumidity(time, humidity)
        begin
            Float(humidity)
        rescue ArgumentError
            @instrumentFailure["hygrometer"] += 1
        end
    end
end



c = WeatherParser.new
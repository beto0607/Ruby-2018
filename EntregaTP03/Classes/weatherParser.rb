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

        @instrumentFailure          = {"thermometer"=> 0.0,"thermal_sensation"=>0.0,"pluviometer"=>0.0,"hygrometer"=>0.0}  #key-> Instrument's name; value-> fails counter
        @instrumentFailure.default  = 0.0 #Hash.new (0) didn't work

        @lineCounter                = 0
    end
    def readFolder(folder)
        if(!File.exists? (folder))then
            puts "File or folder not found"
            raise IOError
            return
        end

        if(File.directory?(folder))then
            files = Dir.entries(folder).select {|f| /(.csv)$/.match(f)}
            if files.length == 0
                puts "Folder don't have any .csv"
                raise IOError
                return
            end
            self.readFiles(files.map {|f| folder+f})
        else
            if (!(/(.csv)$/.match(folder)))
                puts "File isn't a .csv"
                raise IOError
                return
            end
            self.readFile(folder)
        end
        
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
        puts "Worst instrument:\n #{self.worstInstrument[0]}"
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
        @instrumentFailure.reduce("") {|str, (k,v)| str + "Instrument #{k} has: #{ v / @lineCounter}\n"}
    end
    def worstInstrument
        (k,v) = @instrumentFailure.max_by{|k,v| v}
        if(v == 0)then
            nil
        else
            [k,v]
        end
    end
    private
    def parseTemperature(time,temperature)
        begin
            temp = Float(temperature)
            @monthlyTempAVG.increment("#{time.year}/#{time.month}", temp)
            @dailyTempAVG.increment("#{time.year}/#{time.month}/#{time.day}", temp)
            
            @coldestDay.checkTempTo("#{time.year}/#{time.month}", temp, time.day)
            @hotestDay.checkTempTo("#{time.year}/#{time.month}", temp, time.day)

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
            
            @coldestDayTS.checkTempTo("#{time.year}/#{time.month}", temp, time.day)
            @hotestDayTS.checkTempTo("#{time.year}/#{time.month}", temp, time.day)

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
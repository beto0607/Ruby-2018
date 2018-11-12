require_relative 'Classes/weatherParser'

if(ARGV.length == 0)then
    puts "No parameter received. Aborting."
    return 1
end

if(ARGV.length > 1)then
    puts "Received more than 1 parameter, it will use all of them."
end

weatherParser = WeatherParser.new
ARGV.each do |arg|
    puts arg
    begin
        weatherParser.readFolder(arg)
    rescue (IOError)
        puts "Error with parameter: \"#{arg}\". It will continue with the others."
    end
end

weatherParser.showAllInfo
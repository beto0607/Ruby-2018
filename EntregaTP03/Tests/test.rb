require_relative '../Classes/measurementModule'
require_relative '../Classes/weatherParser'

require 'minitest/spec'
require 'minitest/autorun'


describe 'Testing WeatherParser' do
    describe 'Fail errors' do
        it 'should raise IOError' do
            assert_raises (IOError) {(WeatherParser.new).readFolder("inexistent_folder_or_file")}
            assert_raises (IOError) {(WeatherParser.new).readFolder("./test.rb")}
            assert_raises (IOError) {(WeatherParser.new).readFolder(".")}
        end
    end
    
    describe 'Testing init values'do
        it 'returns empty' do
            parser = WeatherParser.new
            assert_equal "", parser.coldestDay
        end
    end

    describe 'Failures in instruments' do
        it 'should return nil' do
            parser = WeatherParser.new
            parser.readFolder "./test_files/without_fail.csv"
            assert_nil parser.worstInstrument
        end
        it 'should return thermal_sensation' do
            parser = WeatherParser.new
            parser.readFolder "./test_files/with_fail.csv"
            assert_equal ["thermal_sensation", 2], parser.worstInstrument
        end
        it 'should return an string' do
            parser = WeatherParser.new
            parser.readFolder "./test_files/with_fail.csv"
            assert_equal "Instrument thermometer has: 0.2\nInstrument thermal_sensation has: 0.4\nInstrument pluviometer has: 0.0\nInstrument hygrometer has: 0.2\n", parser.instrumentFailure
        end
    end
end
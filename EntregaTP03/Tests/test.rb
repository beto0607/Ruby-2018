require 'bundler/setup'
require_relative '../Classes/weatherParser'


require 'test/unit'
require 'mocha/test_unit'


class WeatherParserTest < Test::Unit::TestCase
    def test_just_init
        parser = WeatherParser.new
        WeatherParser.excepts(:tempAVG).returns(Float::NAN)
        assert_equal Float::NAN, parser.tempAVG.avg 
    end


end

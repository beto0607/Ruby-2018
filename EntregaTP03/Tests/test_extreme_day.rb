require_relative '../Classes/measurementModule'

require 'minitest/spec'
require 'minitest/autorun'

describe 'Testing ExtremeDay class'do
    it 'Minor - should return nil' do
        e = Measurement::ExtremeDay.new :<
        assert_nil e.day
        assert_nil e.temp
    end
    it 'Minor - should return day 1 & temp 23' do
        e = Measurement::ExtremeDay.new :<
        e.checkTempTo(24,5)
        e.checkTempTo(25,2)
        e.checkTempTo(23,1)
        assert_equal 1, e.day
        assert_equal 23, e.temp
    end
    it 'Mayor - should return nil' do
        e = Measurement::ExtremeDay.new :>
        assert_nil e.day
        assert_nil e.temp
    end
    it 'Mayor - should return day 2 & temp 25' do
        e = Measurement::ExtremeDay.new :>
        e.checkTempTo(23,1)
        e.checkTempTo(24,5)
        e.checkTempTo(25,2)
        assert_equal 2, e.day
        assert_equal 25, e.temp
    end
    it 'shoul raise ArgumentError' do
        e = Measurement::ExtremeDay.new :>
        e.checkTempTo(23,1)
        assert_raises (ArgumentError){ e.checkTempTo("fadsfa25","asdf2")}
    end
end

describe 'Testing ExtremeDayInTime class'do
    it 'Minor - should return empty' do
        e = Measurement::ExtremeDayInTime.new :<
        assert_equal "", e.to_s
    end
    it 'Minor - should return day 12' do
        e = Measurement::ExtremeDayInTime.new :<
        e.checkTempTo("2018/8", 24, 5)
        e.checkTempTo("2018/8", 25, 2)
        e.checkTempTo("2018/8", 20, 12)
        assert_equal "2018/8 has: 12\n",e.to_s
    end
    it 'Minor - Several months - should return day 12, 2, 5' do
        e = Measurement::ExtremeDayInTime.new :<
        e.checkTempTo("2018/8", 25, 2)
        e.checkTempTo("2018/8", 24, 5)
        e.checkTempTo("2018/8", 20, 12)
        e.checkTempTo("2018/9", 5, 2)
        e.checkTempTo("2018/9", 10, 3)
        e.checkTempTo("2018/9", 8, 5)
        e.checkTempTo("2018/10", 5, 4)
        e.checkTempTo("2018/10", -4, 5)
        e.checkTempTo("2018/10", 0, 12)
        assert_equal "2018/8 has: 12\n2018/9 has: 2\n2018/10 has: 5\n",e.to_s
    end
    it 'Mayor - should return empty' do
        e = Measurement::ExtremeDayInTime.new :>
        assert_equal "", e.to_s
    end
    it 'Mayor - should return day 2' do
        e = Measurement::ExtremeDayInTime.new :>
        e.checkTempTo("2018/8", 24, 5)
        e.checkTempTo("2018/8", 25, 2)
        e.checkTempTo("2018/8", 20, 12)
        assert_equal "2018/8 has: 2\n",e.to_s
    end
    it 'Mayor - Several months - should return day 2, 3, 4' do
        e = Measurement::ExtremeDayInTime.new :>
        e.checkTempTo("2018/8", 24, 5)
        e.checkTempTo("2018/8", 25, 2)
        e.checkTempTo("2018/8", 20, 12)
        e.checkTempTo("2018/9", 5, 2)
        e.checkTempTo("2018/9", 10, 3)
        e.checkTempTo("2018/9", 8, 5)
        e.checkTempTo("2018/10", 5, 4)
        e.checkTempTo("2018/10", -4, 5)
        e.checkTempTo("2018/10", 0, 12)
        assert_equal "2018/8 has: 2\n2018/9 has: 3\n2018/10 has: 4\n",e.to_s
    end
end


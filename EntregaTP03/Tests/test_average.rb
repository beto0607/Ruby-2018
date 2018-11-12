require_relative '../Classes/measurementModule'

require 'minitest/spec'
require 'minitest/autorun'

describe 'Testing AverageNumber class'do
    it 'should return NAN' do
        a = Measurement::AverageNumber.new
        assert_equal (Float::NAN).to_s, a.avg.to_s
    end
    it 'should return 0' do
        a = Measurement::AverageNumber.new
        a.sum (0)
        assert_equal 0, a.avg
    end
    it 'should return 10' do
        a = Measurement::AverageNumber.new
        (1..20).each do |i|
            a.sum i
        end
        assert_equal 10, a.avg
    end
    it 'shoul raise TypeError' do
        a = Measurement::AverageNumber.new
        assert_raises (TypeError){ a.sum "asdfasdf"}
    end
end
describe 'Testing AverageNumberInTime class'do
    it 'should return NAN' do
        a = Measurement::AverageInTime.new
        assert_equal "", a.to_s
    end
    it 'should return 0' do
        a = Measurement::AverageInTime.new
        a.increment "2018/8/1", 0
        assert_equal "2018/8/1 has: 0ºC\n", a.to_s
    end
    it 'should return 10' do
        a = Measurement::AverageInTime.new
        (1..20).each do |i|
            a.increment "2018/8/1",i
        end
        (1..20).each do |i|
            a.increment "2018/8/2", 0
        end
        assert_equal "2018/8/1 has: 10ºC\n2018/8/2 has: 0ºC\n", a.to_s
    end
    it 'shoul raise TypeError' do
        a = Measurement::AverageInTime.new
        assert_raises (TypeError){ a.increment "2018/8/2", "asdfasdf"}
    end
end
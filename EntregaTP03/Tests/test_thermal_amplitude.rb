require_relative '../Classes/measurementModule'

require 'minitest/spec'
require 'minitest/autorun'

describe 'Testing ThermalAmplitude class'do
    it 'should return NAN' do
        a = Measurement::ThermalAmplitude.new
        assert_equal (Float::NAN).to_s, a.to_s
    end
    it 'should return 10' do
        a = Measurement::ThermalAmplitude.new
        a.verify 10
        a.verify 20
        assert_equal "10", a.to_s
    end
    it 'should return 20 - several values' do
        a = Measurement::ThermalAmplitude.new
        (1..21).each do |i|
            a.verify i
        end
        assert_equal "20", a.to_s
    end
    it 'shoul raise ArgumentError' do
        a = Measurement::ThermalAmplitude.new
        assert_raises (ArgumentError){ a.verify "asdfasdf"}
    end
end
describe 'Testing ThermalAmplitudeInTime class'do
    it 'should return NAN' do
        a = Measurement::ThermalAmplitudeInTime.new
        assert_equal "", a.to_s
    end
    it 'should return 10' do
        a = Measurement::ThermalAmplitudeInTime.new
        a.add "2018/8/1", 0
        a.add "2018/8/1", 10
        assert_equal "2018/8/1 has: 10ºC\n", a.to_s
    end
    it 'should return 10' do
        a = Measurement::ThermalAmplitudeInTime.new
        (1..20).each do |i|
            a.add "2018/8/1",i
        end
        (1..20).each do |i|
            a.add "2018/8/2", 0
        end
        assert_equal "2018/8/1 has: 19ºC\n2018/8/2 has: 0ºC\n", a.to_s
    end
    it 'shoul raise ArgumentError' do
        a = Measurement::ThermalAmplitudeInTime.new
        assert_raises (ArgumentError){ a.add "2018/8/2", "asdfasdf"}
    end
end

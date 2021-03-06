#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'test/unit'
case ENV['JSON']
when 'pure' then require 'json/pure'
when 'ext'  then require 'json/ext'
else             require 'json'
end
require 'iconv'

class TC_JSONEncoding < Test::Unit::TestCase
  include JSON

  def setup
    @utf_8 = '["© ≠ €!"]'
    @parsed = [ "© ≠ €!" ]
    @utf_16_data = Iconv.iconv('utf-16be', 'utf-8', @parsed.first)
    @generated = '["\u00a9 \u2260 \u20ac!"]'
    if defined?(::Encoding)
      @utf_8_ascii_8bit = @utf_8.dup.force_encoding(Encoding::ASCII_8BIT)
      @utf_16be, = Iconv.iconv('utf-16be', 'utf-8', @utf_8)
      @utf_16be_ascii_8bit = @utf_16be.dup.force_encoding(Encoding::ASCII_8BIT)
      @utf_16le, = Iconv.iconv('utf-16le', 'utf-8', @utf_8)
      @utf_16le_ascii_8bit = @utf_16le.dup.force_encoding(Encoding::ASCII_8BIT)
      @utf_32be, = Iconv.iconv('utf-32be', 'utf-8', @utf_8)
      @utf_32be_ascii_8bit = @utf_32be.dup.force_encoding(Encoding::ASCII_8BIT)
      @utf_32le, = Iconv.iconv('utf-32le', 'utf-8', @utf_8)
      @utf_32le_ascii_8bit = @utf_32le.dup.force_encoding(Encoding::ASCII_8BIT)
    else
      @utf_8_ascii_8bit = @utf_8.dup
      @utf_16be, = Iconv.iconv('utf-16be', 'utf-8', @utf_8)
      @utf_16be_ascii_8bit = @utf_16be.dup
      @utf_16le, = Iconv.iconv('utf-16le', 'utf-8', @utf_8)
      @utf_16le_ascii_8bit = @utf_16le.dup
      @utf_32be, = Iconv.iconv('utf-32be', 'utf-8', @utf_8)
      @utf_32be_ascii_8bit = @utf_32be.dup
      @utf_32le, = Iconv.iconv('utf-32le', 'utf-8', @utf_8)
      @utf_32le_ascii_8bit = @utf_32le.dup
    end
  end

  def test_parse
    assert_equal @parsed, JSON.parse(@utf_8)
    assert_equal @parsed, JSON.parse(@utf_16be)
    assert_equal @parsed, JSON.parse(@utf_16le)
    assert_equal @parsed, JSON.parse(@utf_32be)
    assert_equal @parsed, JSON.parse(@utf_32le)
  end

  def test_parse_ascii_8bit
    assert_equal @parsed, JSON.parse(@utf_8_ascii_8bit)
    assert_equal @parsed, JSON.parse(@utf_16be_ascii_8bit)
    assert_equal @parsed, JSON.parse(@utf_16le_ascii_8bit)
    assert_equal @parsed, JSON.parse(@utf_32be_ascii_8bit)
    assert_equal @parsed, JSON.parse(@utf_32le_ascii_8bit)
  end

  def test_generate
    assert_equal @generated, JSON.generate(@parsed)
    if defined?(::Encoding)
      assert_equal @generated, JSON.generate(@utf_16_data)
    else
       assert_raises(JSON::GeneratorError) { JSON.generate(@utf_16_data) }
    end
  end
end

#!/usr/bin/env ruby
require "rubygems"
require "../lib/bbcode"
require "bbcodeizer/lib/bbcodeizer"
require "redcloth"
require "maruku"
require "benchmark"

include Benchmark

bbcode = BBos::BBCode.new
bbcode_markup =File.readlines("performance.bbcode").join("\n")
textile_markup =File.readlines("performance.textile").join("\n")
markdown_markup =File.readlines("performance.markdown").join("\n")

loop_count = 10

puts "My BBCode"
Benchmark.benchmark(" "*10 + CAPTION, 10, FMTSTR, ">total:", ">avg:") do |x|
  results = []
  loop_count.times do |i|
    results << x.report("##{i}") { bbcode.to_html(bbcode_markup) }
  end
  sum = results.inject() {|sum, item| sum + item}
  [sum, sum / loop_count]
end

puts

puts "bbcodeizer"
Benchmark.benchmark(" "*10 + CAPTION, 10, FMTSTR, ">total:", ">avg:") do |x|
  results = []
  loop_count.times do |i|
    results << x.report("##{i}") { BBCodeizer.bbcodeize(bbcode_markup) }
  end
  sum = results.inject() {|sum, item| sum + item}
  [sum, sum / loop_count]
end

puts

puts "RedCloth"
Benchmark.benchmark(" "*10 + CAPTION, 10, FMTSTR, ">total:", ">avg:") do |x|
  results = []
  loop_count.times do |i|
    results << x.report("##{i}") { RedCloth.new(textile_markup).to_html }
  end
  sum = results.inject() {|sum, item| sum + item}
  [sum, sum / loop_count]
end

puts

puts "Maruku"
Benchmark.benchmark(" "*10 + CAPTION, 10, FMTSTR, ">total:", ">avg:") do |x|
  results = []
  loop_count.times do |i|
    results << x.report("##{i}") { Maruku.new(markdown_markup).to_html }
  end
  sum = results.inject() {|sum, item| sum + item}
  [sum, sum / loop_count]
end

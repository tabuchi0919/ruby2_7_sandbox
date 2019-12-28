# frozen_string_literal: true

require 'benchmark'

N = 10_000
range = 1.upto(10_000)

Benchmark.bmbm do |x|
  x.report('select + map') do
    N.times { range.select(&:even?).map { |i| i + 1 } }
  end
  x.report('map + compact') do
    N.times { range.map { |i| i + 1 if i.even? }.compact }
  end
  x.report('dup + map! + compact!') do
    N.times { range.dup.map! { |i| i + 1 if i.even? }.compact! }
  end
  x.report('filter_map') do
    N.times { range.filter_map { |i| i + 1 if i.even? } }
  end
end

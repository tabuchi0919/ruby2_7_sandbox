# frozen_string_literal: true

require 'benchmark'

N = 10_000
rands = 10_000.times.map { rand(10) }

Benchmark.bmbm do |x|
  x.report('group_by + to_h + count') do
    N.times { rands.group_by { _1 }.to_h { |k, v| [k, v.count] } }
  end
  x.report('each_with_object') do
    N.times { rands.each_with_object({}) { |rand, result| result[rand] = result[rand] ? result[rand] + 1 : 1 } }
  end
  x.report('each_with_object 2') do
    N.times { rands.each_with_object((0..9).to_h { |i| [i, 0] }) { |rand, result| result[rand] += 1 } }
  end
  x.report('tally') do
    N.times { rands.tally }
  end
end

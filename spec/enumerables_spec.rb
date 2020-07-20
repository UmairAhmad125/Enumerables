require_relative '../enumerables.rb'

# rubocop:disable Metrics/BlockLength
describe 'Enumerable' do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:str_array) { %w[hi hello hey] }
  let(:range) { 0..5 }
  let(:my_hash) { {} }
  let(:select_proc) { proc { |x| x > 2 } }
  let(:my_all_proc1) { proc { |x| x > 2 } }
  let(:my_all_proc2) { proc { |x| x.class == Integer } }
  my_hash = { a: 1, b: 2, c: 3, d: 4, e: 5 }
  let(:index_proc) { proc { |e, i| puts e, i } }
  let(:inject_proc) { proc { |e| e } }
  let(:map_proc) { proc { |x| x * x } }

  describe '#my_each' do
    count = 0
    it 'iterates through the block and yield' do
      expect(array.my_each { |x| x }).to eql([1, 2, 3, 4, 5])
    end
    it 'return enum if block is not given' do
      expect(array.my_each).to be_a Enumerable
    end
    it 'returns the count of the array' do
      array.my_each { |_x| count += 1 }
      expect(count).to eql(5)
    end
    it 'returns the keys and values of hash' do
      expect(my_hash.my_each { |k, v| }).to eql({ a: 1, b: 2, c: 3, d: 4, e: 5 })
    end
    it 'returns the range' do
      expect(range.my_each { |r| }).to eql(0..5)
    end
  end

  describe '#my_each_with_index' do
    count = 0
    it 'iterates through the block and yield' do
      expect(array.my_each_with_index { |x| x }).to eql([1, 2, 3, 4, 5])
    end
    it 'return enum if block is not given' do
      expect(array.my_each_with_index).to be_a Enumerable
    end
    it 'returns the count of the array' do
      array.my_each_with_index { |_x| count += 1 }
      expect(count).to eql(5)
    end
    it 'returns the keys and values of hash' do
      expect(my_hash.my_each_with_index { |k, v| }).to eql({ a: 1, b: 2, c: 3, d: 4, e: 5 })
    end
    it 'returns the range' do
      expect(range.my_each_with_index { |r| }).to eql(0..5)
    end
    it 'returns array elements and imdex' do
      expect(array.my_each_with_index(&index_proc)).to eq(array.each_with_index(&index_proc))
    end
  end

  describe '#my_select' do
    it 'return enum if block is not given' do
      expect(array.my_select).to be_a Enumerable
    end

    it 'return elements that return true from yield when called on an array' do
      expect(array.my_select(&select_proc)).to eq(array.select(&select_proc))
    end

    it 'return elements that return true from yield when called on an array' do
      expect(array.my_select(&select_proc)).not_to eq(array)
    end

    it 'return elements that return true from yield when called on  a range' do
      expect(range.my_select(&select_proc)).to eq(range.select(&select_proc))
    end
  end

  describe '#my_all' do
    it 'return false if yield returns false' do
      expect(array.my_all?(&my_all_proc1)).to be false
    end

    it 'return true if yield does not return false' do
      expect(array.my_all?(&my_all_proc2)).to eq(array.all?(&my_all_proc2))
    end

    it 'should use block when provided with one' do
      expect(array.my_all?(&my_all_proc2)).to eq(array.all?(&my_all_proc2))
    end

    it 'should accept and use a class argument and use it to test against self' do
      expect(array.my_all?(Integer)).to eq(array.all?(Integer))
    end

    it 'should accept and use a RegExp argument and use it to test against self' do
      expect(str_array.my_all?(/hi/)).to eq(str_array.all?(/hi/))
    end

    it 'should accept arguments and use it to test against self' do
      expect(str_array.my_all?('hi')).to eq(str_array.all?('hi'))
    end
  end

  describe '#my_any' do
    it 'return true if yield returns true for any element' do
      expect(array.my_any?(&my_all_proc1)).to be true
    end

    it 'return false if yield does not return true for any element' do
      expect(array.my_any?(&my_all_proc2)).to eq(array.any?(&my_all_proc2))
    end

    it 'should use block when provided with one and use it to test against self' do
      expect(array.my_any?(&my_all_proc2)).to eq(array.any?(&my_all_proc2))
    end

    it 'should accept and use a class argument and use it to test against self' do
      expect(array.my_any?(Integer)).to eq(array.any?(Integer))
    end

    it 'should accept and use a class RegExp and use it to test against self' do
      expect(str_array.my_any?(/hi/)).to eq(str_array.any?(/hi/))
    end

    it 'should accept and use an argument and use it to test against self' do
      expect(str_array.my_any?('hi')).to eq(str_array.any?('hi'))
    end
  end

  describe '#my_none' do
    it 'return true if yield returns true for any element' do
      expect(array.my_none?(&my_all_proc1)).to be false
    end

    it 'return false if yield does not return true for any element' do
      expect(array.my_none?(&my_all_proc2)).to eq(array.none?(&my_all_proc2))
    end

    it 'should use block when provided with one and use it to test against self' do
      expect(array.my_none?(&my_all_proc2)).to eq(array.none?(&my_all_proc2))
    end

    it 'should accept and use a class argument and use it to test against self' do
      expect(array.my_none?(Integer)).to eq(array.none?(Integer))
    end

    it 'should accept and use a class RegExp and use it to test against self' do
      expect(str_array.my_none?(/hi/)).to eq(str_array.none?(/hi/))
    end

    it 'should accept and use an argument and use it to test against self' do
      expect(str_array.my_none?('hi')).to eq(str_array.none?('hi'))
    end
  end

  describe '#my_inject' do
    it 'should raise LocalJumpError if no block or argument is given' do
      expect { array.my_inject }.to raise_error(LocalJumpError)
    end

    it 'returns and computes the function passing in block/proc for Range' do
      expect(range.my_inject(&inject_proc)).to eq(range.inject(&inject_proc))
    end

    it 'returns and computes the function passing in block/proc for Array' do
      expect(array.my_inject(&inject_proc)).to eq(array.inject(&inject_proc))
    end

    it 'returns the end result by computing the elements accoridng to first parameter' do
      expect(array.my_inject(:+)).to eq(array.inject(:+))
    end

    it 'computes the opertion if second parameter is given (operator) and first is a variable' do
      expect(array.my_inject(3, :*)).to eq(array.inject(3, :*))
    end
  end
  describe '#my_count' do
    it 'returns the number of element' do
      expect(array.my_count).to eq(5)
    end

    it 'returns elements given in parameter' do
      expect(range.my_count(&my_all_proc1)).to eq(3)
    end
  end
  describe '#my_map' do
    it 'return enum if block is not given' do
      expect(array.my_map).to be_a Enumerable
    end
    it 'returns the elements after yield' do
      expect(array.my_map(&map_proc)).to eq(array.map(&map_proc))
    end

    it 'returns elements in range by yielding' do
      expect(range.my_map(&map_proc)).to eq(range.map(&map_proc))
    end
  end
end
# rubocop:enable Metrics/BlockLength

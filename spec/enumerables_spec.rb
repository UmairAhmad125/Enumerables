# rubocop:disable Metrics/BlockLength
require '../enumerables.rb'

describe 'Enumerable' do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:range) { 0..5 }
  let(:my_hash) { {} }
  my_hash = { a: 1, b: 2, c: 3, d: 4, e: 5 }
  let(:index_block) { proc { |e, i| puts e, i } }
  # my_proc = proc{|x| x}
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
      expect(array.my_each_with_index(&index_block)).to eq(array.each_with_index(&index_block))
    end
  end
end
# rubocop:enable Metrics/BlockLength

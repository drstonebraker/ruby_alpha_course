require 'rspec'
require 'spec_helper'
require 'a-1'

describe 'missing_numbers' do 
  
  it 'returns the correct numbers ordered from least to greatest' do 
    expect(missing_numbers([2, 3, 7])).to eq([4, 5, 6])
  end
  
  it 'returns an empty array if no numbers are needed to complete the set' do 
    expect(missing_numbers([1, 2, 3])).to eq([])
  end

  it 'works with negative numbers' do 
    expect(missing_numbers([-4, 1, 4])).to eq([-3, -2, -1, 0, 2, 3])
  end

  it 'can handle larger sets' do 
    expect(missing_numbers([2, 2000])).to eq((3..1999).to_a)
  end

end

describe 'base2to10' do 

  it 'does not use Ruby\'s built in method for base conversion' do 
    expect_any_instance_of(String).to_not receive(:to_i)
  end

  it 'correctly converts the binary number 10 to base 10' do
    expect(base2to10("10")).to eq(2)
  end

  it 'correctly converts the binary number 1100 to base 10' do 
    expect(base2to10("1100")).to eq(12)
  end

  it 'correctly converts the binary number 1010101 to base 10' do 
    expect(base2to10("1010101")).to eq(85)
  end

end

describe 'Hash#my_select' do 
  
  it 'does not call the built in Hash#select' do 
    test_hash = {a: 1, b: 2, c: 3}
    expect(test_hash).not_to receive(:select)
    test_hash.my_select {}  
  end

  it 'yields each element to the block' do 
    test_hash = {a: 1, b: 2, c: 3}
    expect { |b| test_hash.my_select(&b)}.to yield_successive_args([:a, 1], [:b, 2], [:c, 3])
  end

  it 'returns a hash of filtered key-value pairs based on key' do 
    test_hash = {a: 1, b: 2, c: 3}
    expect(test_hash.my_select { |k, v| k == :a }).to eq({a: 1})
  end
  
  it 'returns a hash of filtered key-value pairs based on value' do 
    test_hash = {a: 1, b: 2, c: 3}
    expect(test_hash.my_select { |k, v| v >= 2 }).to eq({b: 2, c: 3})
  end

end

describe 'Hash#my_merge' do 

  it 'does not call the built in Hash#merge' do 
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { b: 3, c: 4 }
    expect(test_hash_1).not_to receive(:merge)
    expect(test_hash_2).not_to receive(:merge)
    test_hash_1.my_merge(test_hash_2) {}
  end

  it 'provides default merging behavior if no proc given' do 
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { b: 3, c: 4 }
    expect(test_hash_1.my_merge(test_hash_2)).to eq({a: 10, b: 3, c: 4})
  end
 
  it 'yields each element to the block' do 
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { b: 3, c: 4 }
    expect { |b| test_hash_1.my_merge(test_hash_2, &b)}.to yield_successive_args([:b, 2, 3])
  end

  it 'returns a hash with the correct key-value pairs' do 
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { a: 5, b: 10, c: 3 }
    expect(test_hash_1.my_merge(test_hash_2) { |key, oldval, newval| newval - oldval }).to eq({a: -5, b: 8, c: 3})
  end

end

describe 'lucas_numbers' do 
  
  it 'returns the correct number at the 0th index' do 
    expect(lucas_numbers(0)).to eq(2)
  end

  it 'returns the correct number at the 5th index' do 
    expect(lucas_numbers(5)).to eq(11)
  end

  it 'returns the corrent number at the -4 index' do 
    expect(lucas_numbers(-4)).to eq(7)
  end

  it 'returns the correct number at a really big index' do 
    expect(lucas_numbers(123)).to eq(50755107359004694554823204)
  end

end

describe 'longest_palindrome' do 

  it 'returns false if there is no palindrome longer than two letters' do 
    expect(longest_palindrome("palindrome")).to eq(false)
  end

  it 'returns the correct length of the palindrome' do
    expect(longest_palindrome("181847117432")).to eq(6)
  end

  it 'returns the correct length for the longest palindrome in the string' do 
    expect(longest_palindrome("noonminimum")).to eq(5)
  end

end

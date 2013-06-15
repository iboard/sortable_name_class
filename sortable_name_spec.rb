# -*- encoding : utf-8 -*-
require 'simplecov'
require 'rspec'
SimpleCov.start

require_relative './sortable_name'

describe SortableName do

  def join(first,last)
    [first,last].join(' ').strip
  end


  context 'Without intput' do

    it 'Computer says, no.' do
      expect{ SortableName.new }.to raise_error 'Computer says, no.'
    end

  end

  context 'With any data' do

    it 'make sure parser runs on initialize' do
      SortableName.any_instance.should_receive(:parse)
      SortableName.new ''
    end

    it 'make sure format_sortable is called before :to_s' do
      SortableName.any_instance.should_receive(:format_sortable)
      SortableName.new('').to_s
    end

  end

  context 'Pairs of possible input and expected outputs' do

    let(:postnominals)  { SortableName::POSTNOMINALS }

    #  input               expected output       Scenario
    let(:pairs) {[
     ['',                  ''           ],       # Empty is empty
     ['Name',              'Name'       ],       # Simple name
     ['First Last',        'Last, First'],       # Reverse First Last
     ['First van Last',    'Last, First van'],   # Rearrange last part of name 
     ['  Name  ',          'Name'       ],       # Single name with surrounding blanks
     ['  First    Last  ', 'Last, First'],       # Decorating blanks everywhere
     ['Robert C. Martin',  'Martin, Robert C.'], # With middle name
    ]}

    it 'passes all plain examples' do
      for pair in pairs do
        expect( SortableName.new(pair.first).to_s ).to eq(pair.last)
      end
    end

    it 'passes all examples with leading honorifics' do
      for pair in pairs do
        expect( SortableName.new( " Mr. Mrs. Ms. " + pair.first).to_s).to eq(pair.last)
      end
    end

    it 'passes all examples with trailing post nominals' do
      for pair in pairs do
        expect( SortableName.new(join(pair.first,postnominals)).to_s).to eq(join(pair.last,postnominals))
      end
    end

  end
  
  describe 'Integration' do

    let(:sortable) { SortableName.new '  Mr.  James  Edward Gray II JEG2  ' }

    it 'outputs formatted' do
      expect(sortable.to_s).to eq('Gray, James Edward II JEG2')
    end

    it 'outputs unformatted' do
      expect(sortable.to_s false ).to eq('Mr. James Edward Gray II JEG2')
    end

  end

end




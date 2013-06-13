# -*- encoding : utf-8 -*-
require 'simplecov'
require 'rspec'
SimpleCov.start

require_relative './sortable_name'

describe SortableName do

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
    #  input                     expected output
    let(:pairs) {[
     ['',                        ''           ],
     ['Name',                    'Name'       ],
     ['First Last',              'Last, First'],
     ['Mr. Last',                'Last'       ],
     ['Mr. First Last',          'Last, First'],
     ['Mrs. First Last',         'Last, First'],
     ['Ms. First Last',          'Last, First'],
     ['Last PhD.',               'Last PhD.'       ],
     ['First Last PhD.',         'Last, First PhD.'],
     ['Mr. First van Last PhD.', 'Last, First van PhD.'],
     ['  Name  ',                'Name'       ],
     ['  First    Last  ',       'Last, First'],
     ['  Mr.   First Last',      'Last, First'],
     ['Mr. First Last jun.',     'Last, First jun.'],
     ['Mr. Last sen.',           'Last sen.'],
     ['Mr. Robert C. Martin Esq','Martin, Robert C. Esq'],
     # If you miss a possible form:
     #   # add the pair here and make the test pass.
     #   # run `rspec --format d name_sorter_spec.rb`
     #   # Clean up your mess and make sure you have 100% LOC 
     #
     # If all tests pass and you have uncovered LOC:
     #   # open coverage/index.html, locate the uncovered LOC
     #   # AND DELETE THEM
    ]}

    # Let' test all pairs ...
    # Ouput with puts is not necessary. It's here for demo only.
    # If a pair fails rspec will tell you exactly what was expected 
    # and what was returned.
    it 'passes all examples' do
      for pair in pairs do
        puts "\t%30s => %-30s" % [pair.first.inspect, pair.last.inspect]
        expect( SortableName.new(pair.first).to_s ).to eq(pair.last)
      end
    end

  end
  
  describe 'Integration' do

    let(:sortable) { SortableName.new 'Mr. James Edward Gray II JEG2' }

    it 'outputs formatted' do
      expect(sortable.to_s).to eq('Gray, James Edward II JEG2')
    end

    it 'outputs unformatted' do
      expect(sortable.to_s false ).to eq('Mr. James Edward Gray II JEG2')
    end

  end

end

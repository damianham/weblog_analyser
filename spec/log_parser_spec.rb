require 'spec_helper'
require_relative '../lib/log_parser'

RSpec.describe LogParser do
  describe 'initialization' do
    it 'creates a log parser with no entries for an empty file' do
      parser = LogParser.new 'fixtures/empty.log'
      expect(parser.size).to be(0)
    end

    it 'creates a log parser with an entry for each path' do
      parser = LogParser.new 'fixtures/most_views.log'
      expect(parser.size).to be(3) # there are 3 paths in most_views.log
    end

    it 'throws an exception if the log file does not exist' do
      expect { LogParser.new 'nonexistent.log' }.to raise_error 'no such file nonexistent.log'
    end
  end

  describe '#entries' do
    let (:parser) { LogParser.new 'fixtures/most_views.log' }

    it 'returns all entries' do
      expect(parser.entries.size).to be(3)
    end
  end

  describe '#views' do
    let (:parser) { LogParser.new 'fixtures/most_views.log' }

    it 'returns the number of views for each path' do
      expect(parser.entries['/about'].views).to be(10)
      expect(parser.entries['/about/2'].views).to be(8)
      expect(parser.entries['/contact'].views).to be(14)
    end

    it 'returns the entries ordered by most views descending' do
      expect(parser.visits[0].views).to be(14)
      expect(parser.visits[0].path).to eq('/contact')
      expect(parser.visits[1].views).to be(10)
      expect(parser.visits[1].path).to eq('/about')
      expect(parser.visits[2].views).to be(8)
      expect(parser.visits[2].path).to eq('/about/2')
    end
  end

  describe '#unique' do
    let (:parser) { LogParser.new 'fixtures/unique_views.log' }

    it 'returns the number of unique views for each path' do
      expect(parser.entries['/about'].unique).to be(2)
      expect(parser.entries['/about/2'].unique).to be(3)
      expect(parser.entries['/contact'].unique).to be(1)
    end

    it 'returns the entries ordered by most unique views descending' do
      expect(parser.unique_views[0].unique).to be(3)
      expect(parser.unique_views[0].path).to eq('/about/2')
      expect(parser.unique_views[1].unique).to be(2)
      expect(parser.unique_views[1].path).to eq('/about')
      expect(parser.unique_views[2].unique).to be(1)
      expect(parser.unique_views[2].path).to eq('/contact')
    end
  end
end

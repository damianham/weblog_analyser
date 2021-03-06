require 'spec_helper'
require_relative '../lib/entry'

RSpec.describe Entry do
  context 'basic operations' do
    let(:entry) { Entry.new '/about' }

    describe 'initialisation' do
      it 'should have no views' do
        expect(entry.views).to be(0)
      end
    end

    describe '#add_view' do
      it 'should add a new page view to the entry' do
        entry.add_view '016.464.657.359'
        expect(entry.views).to be(1)
      end
    end

    describe '#path' do
      it 'should get the path of the entry' do
        expect(entry.path).to eq('/about')
      end
    end

    describe '#views' do
      it 'should get the number of views of the entry' do
        entry.add_view '016.464.657.359'
        entry.add_view '016.464.657.359'
        expect(entry.views).to be(2)
      end
    end

    describe '#unique' do
      it 'should get the number of unique views of the entry' do
        entry.add_view '016.464.657.359'
        entry.add_view '016.464.657.359'
        expect(entry.unique).to be(1)
      end
    end
  end
end

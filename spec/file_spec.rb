require 'spec_helper'

describe Douglas::NE::Checks::File do

  before(:all) do
    @file = Douglas::NE::Checks::File.new(data_files.first)
  end

  subject { @file }

  context '12532 - COUNTY ROAD' do

    subject { @file.data['12532 - COUNTY ROAD'] }

    it { should have(3).keys }

    its(:keys) { should include('670011 - DESIGN & SURVEY') }
    its(:keys) { should include('672011 - MAINTENANCE') }
    its(:keys) { should include('674011 - EQUIPMENT') }

    context '670011 - DESIGN & SURVEY' do

      subject { @file.data['12532 - COUNTY ROAD']['670011 - DESIGN & SURVEY'] }

      it { should have(1).row }

      context 'row 0' do

        subject { @file.data['12532 - COUNTY ROAD']['670011 - DESIGN & SURVEY'][0] }

        it 'should have known values' do
          expect(subject[:supplier]).to eql('METROPOLITAN AREA PLANNING AGENCY')
          expect(subject[:account]).to eql('42239 - PROFESSIONAL FEES - OTHER')
          expect(subject[:description]).to eql('INV 2608 (NIROC FUNDING)')
          expect(subject[:invoice]).to eql('2603')
          expect(subject[:check_number]).to eql(363827)
          expect(subject[:check_date]).to eql(Date.new(2013, 9, 10))
          expect(subject[:check_status]).to eql('NEGOTIABLE')
          expect(subject[:amount]).to be_within(0.01).of(25000.00)
        end

      end

    end

    context '672011 - MAINTENANCE' do

      subject { @file.data['12532 - COUNTY ROAD']['672011 - MAINTENANCE'] }

      it { should have(30).rows }

    end

    context '674011 - EQUIPMENT' do

      subject { @file.data['12532 - COUNTY ROAD']['674011 - EQUIPMENT'] }

      it { should have(2).rows }

    end

  end

end

require 'spec_helper'

describe Douglas::NE::Checks::File do

  describe '#funds' do

    context '2013-06-04.htm' do

      before(:all) do
        @file = Douglas::NE::Checks::File.new(data_file('2013-06-04.htm'))
      end

      subject { @file.funds }

      it { should have(12).keys }

    end

    context '2013-09-09.htm' do

      before(:all) do
        @file = Douglas::NE::Checks::File.new(data_file('2013-09-09.htm'))
      end

      subject { @file.funds }

      it { should have(12).keys }

      context '11111 - GENERAL' do

        subject { @file.funds['11111 - GENERAL'] }

        it { should have(62).keys }

      end

      context '12532 - COUNTY ROAD' do

        subject { @file.funds['12532 - COUNTY ROAD'] }

        it { should have(3).keys }

        its(:keys) { should include('670011 - DESIGN & SURVEY') }
        its(:keys) { should include('672011 - MAINTENANCE') }
        its(:keys) { should include('674011 - EQUIPMENT') }

        context '670011 - DESIGN & SURVEY' do

          subject { @file.funds['12532 - COUNTY ROAD']['670011 - DESIGN & SURVEY'] }

          it { should have(1).row }

          context 'row 0' do

            subject { @file.funds['12532 - COUNTY ROAD']['670011 - DESIGN & SURVEY'][0] }

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

          subject { @file.funds['12532 - COUNTY ROAD']['672011 - MAINTENANCE'] }

          it { should have(30).rows }

        end

        context '674011 - EQUIPMENT' do

          subject { @file.funds['12532 - COUNTY ROAD']['674011 - EQUIPMENT'] }

          it { should have(2).rows }

        end

      end

      context '12516 - VETERANS' do

        subject { @file.funds['12516 - VETERANS'] }

        it { should have(1).keys }

        its(:keys) { should include('656011 - VETERANS') }

      end

      context '12582 - EMPLOYEE MEDICAL INS' do

        subject { @file.funds['12582 - EMPLOYEE MEDICAL INS'] }

        it { should have(2).keys }

        its(:keys) { should include('695011 - MED INSURANCE') }
        its(:keys) { should include('695012 - WELLNESS') }

      end

    end

  end

end

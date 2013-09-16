require 'spec_helper'

describe Douglas::NE::Checks::File do

  before(:all) do
    @file6 = Douglas::NE::Checks::File.new(data_file('2013-06-04.htm'))
    @file9 = Douglas::NE::Checks::File.new(data_file('2013-09-09.htm'))
  end

  describe '#fund_names' do

    context '2013-06-04.htm' do

      subject { @file6.fund_names }

      it { should have(12).names }

    end

    context '2013-09-09.htm' do

      subject { @file9.fund_names }

      it { should have(12).names }

    end

  end

  describe '#fund' do

    context '2013-06-04.htm' do

      let(:file) { @file6 }

      it 'should have known funds' do
        expect(file.fund('11111 - GENERAL')).to_not be_nil
        expect(file.fund('11111 - GENERAL')).to be_a(Hash)
      end

    end

    context '2013-09-09.htm' do

      let(:file) { @file9 }

      it 'should have known funds' do
        expect(file.fund('12535 - FEDERAL DRUG FORFEITURE')).to_not be_nil
        expect(file.fund('12535 - FEDERAL DRUG FORFEITURE')).to be_a(Hash)
      end

    end

  end

  describe '#raw_data' do

    context '2013-06-04.htm' do

      let(:file) { @file6 }

      subject { file.raw_data }

      it_behaves_like 'raw data'

      context '[:funds]' do

        subject { file.raw_data[:funds] }

        it_behaves_like 'raw data funds', 12

      end

    end

    context '2013-09-09.htm' do

      let(:file) { @file9 }

      subject { file.raw_data }

      it_behaves_like 'raw data'

      context '[:funds]' do

        subject { file.raw_data[:funds] }

        it_behaves_like 'raw data funds', 12

        context '11111 - GENERAL' do

          it_behaves_like 'a raw data fund', 62

        end

        context '12532 - COUNTY ROAD' do

          it_behaves_like 'a raw data fund', 3

          context '670011 - DESIGN & SURVEY' do

            it_behaves_like 'a raw data fund organization', 1

            context 'entry 0' do

              it_behaves_like 'a raw data fund organization entry', 0, {
                supplier: 'METROPOLITAN AREA PLANNING AGENCY',
                account: '42239 - PROFESSIONAL FEES - OTHER',
                description: 'INV 2608 (NIROC FUNDING)',
                invoice: '2603',
                check_number: 363827,
                check_date: Date.new(2013, 9, 10),
                check_status: 'NEGOTIABLE',
                amount: 25000.00
              }

            end

          end

          context '672011 - MAINTENANCE' do

            it_behaves_like 'a raw data fund organization', 30

          end

          context '674011 - EQUIPMENT' do

            it_behaves_like 'a raw data fund organization', 2

          end

        end

        context '12516 - VETERANS' do

          it_behaves_like 'a raw data fund', 1

          context '656011 - VETERANS' do

            it_behaves_like 'a raw data fund organization', 1

          end

        end

        context '12582 - EMPLOYEE MEDICAL INS' do

          it_behaves_like 'a raw data fund', 2

          context '695011 - MED INSURANCE' do

            it_behaves_like 'a raw data fund organization', 3

          end

          context '695012 - WELLNESS' do

            it_behaves_like 'a raw data fund organization', 1

          end

        end

      end

    end

  end

end

require 'spec_helper'

shared_examples 'raw data' do

  it { should be_a(Hash) }

  it { should have(1).keys }

  it { should have_key(:funds) }

end

shared_examples 'raw data funds' do |key_count|

  it { should have(key_count).keys }

  it { should be_a(Array) }

end

shared_examples 'a raw data fund' do |org_count|

  let(:fund_name) { example.metadata[:example_group][:example_group][:description] }

  subject { file.raw_data[:funds].find { |f| f[:name] == fund_name } }

  it { should be_a(Hash) }

  it { should have_key(:name) }

  it { should have_key(:organizations) }

  it 'should have a known quantity of organizations' do
    expect(subject[:organizations]).to have(org_count).values
  end

end

shared_examples 'a raw data fund organization' do |entry_count|

  let(:fund_name) { example.metadata[:example_group][:example_group][:example_group][:description] }

  let(:org_name) { example.metadata[:example_group][:example_group][:description] }

  subject do
    fund = file.raw_data[:funds].find { |f| f[:name] == fund_name }
    fund[:organizations].find { |o| o[:name] == org_name }
  end

  it { should be_a(Hash) }

  it { should have_key(:name) }

  it { should have_key(:entries) }

  it 'should have a known quantity of entries' do
    expect(subject[:entries]).to have(entry_count).values
  end

end

shared_examples 'a raw data fund organization entry' do |entry_index, values|

  let(:fund_name) { example.metadata[:example_group][:example_group][:example_group][:example_group][:description] }

  let(:org_name) { example.metadata[:example_group][:example_group][:example_group][:description] }

  subject do
    fund = file.raw_data[:funds].find { |f| f[:name] == fund_name }
    org = fund[:organizations].find { |o| o[:name] == org_name }
    org[:entries][entry_index]
  end

  it { should be_a(Hash) }

  it 'should have known values' do
    expect(subject[:supplier]).to eql(values[:supplier])
    expect(subject[:account]).to eql(values[:account])
    expect(subject[:description]).to eql(values[:description])
    expect(subject[:invoice]).to eql(values[:invoice])
    expect(subject[:check_number]).to eql(values[:check_number])
    expect(subject[:check_date]).to eql(values[:check_date])
    expect(subject[:check_status]).to eql(values[:check_status])
    expect(subject[:amount]).to be_within(0.01).of(values[:amount])
  end

end

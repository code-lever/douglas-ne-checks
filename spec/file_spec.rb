require 'spec_helper'

describe Douglas::NE::Checks::File do

  subject { Douglas::NE::Checks::File.new(data_files.first) }

  it { should respond_to(:to_s) }

end

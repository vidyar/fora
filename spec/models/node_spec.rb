require 'spec_helper'

describe Node do
  it { should respond_to(:topics) }
  it { should validate_presence_of(:key)  }
  it { should validate_presence_of(:name) }
end

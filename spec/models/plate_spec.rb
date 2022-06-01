require 'rails_helper'

RSpec.describe Plate, type: :model do
  it {is_expected.to validate_presence_of :serial}

  it "can't have a serial with AAA-123" do
    subject.serial = "AAA-123"
    subject.valid?
    expect(subject.errors.full_messages).to include("Serial is invalid")
  end
end

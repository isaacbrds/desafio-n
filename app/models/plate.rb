class Plate
  include Mongoid::Document
  include Mongoid::Timestamps
  field :serial, type: String
  field :time, type: String
  field :paid, type: Mongoid::Boolean, default: false
  field :left, type: Mongoid::Boolean, default: false

  SERIAL_REGEX = /\A\w{3}-\d{4}\z/

  validates :serial, presence: true
  validates :serial, format: {with: SERIAL_REGEX}
end

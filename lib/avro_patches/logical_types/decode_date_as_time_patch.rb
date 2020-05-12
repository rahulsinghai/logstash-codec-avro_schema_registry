# The avro-patches gem will convert some date-related logical-types in
# Avro schemas to Ruby Date and Time objects.
#
# LogStash has methods to convert certain Ruby classes into JSON
# values, but it does not support Ruby's Date class. It does support
# Time (which is used by the timestamp-micros and timestamp-millis
# logical types), so we convert the Date object to Time here.
Avro::LogicalTypes::IntDate.class_eval do
  EPOCH = Time.utc(1970,"jan",1,0,0,0)

  def self.decode(daysSinceEpoch)
    EPOCH + (daysSinceEpoch * (24 * 60 * 60))
  end
end

module NEM
  module NEM12
    # This class represents an interval data record.
    class IntervalData < Record
      def self.fields
        {
          record_identifier: 0,
          date: 1,
          quality_method: 1,
          reason_code: 2,
          reason_description: 3,
          updated_at: 4,
          msats_loaded_at: 5
        }
      end

      def self.row_to_hash(row, interval_count, interval_length)
        start_index = 2
        end_index = interval_count + 1
        date = Date.parse(row[fields[:date]])
        time = date.to_time

        values = (start_index..end_index).map.with_index do |row_index, i|
          { read_at: time + (i * interval_length).minutes, value: row[row_index].to_d }
        end

        {
          date: date,
          quality_method: row[end_index + fields[:quality_method]],
          reason_code: row[end_index + fields[:reason_code]],
          reason_description: row[end_index + fields[:reason_description]],
          updated_at: row[end_index + fields[:updated_at]],
          msats_loaded_at: row[end_index + fields[:msats_loaded_at]],
          values: values
        }
      end
    end
  end
end

module NEM
  module NEM12
    # This class represents a data detail record. This record contains the META information
    # related to the subsequent records and applies until another data detail record occurs.
    class DataDetail < Record
      def self.fields
        {
          identifier: 0,
          nmi: 1,
          nmi_configuration: 2,
          register_id: 3,
          nmi_suffix: 4,
          mdm_data_stream_identifier: 5,
          meter_serial_number: 6,
          unit_of_measure: 7,
          interval_length: 8,
          next_scheduled_read_on: 9
        }
      end

      def interval_length
        @attributes[:interval_length].to_i
      end

      def interval_count
        1440 / interval_length.to_i
      end

      def match?(options)
        options.all? do |key, value|
          self.public_send(key.to_sym) == value
        end
      end
    end
  end
end

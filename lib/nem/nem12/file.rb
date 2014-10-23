module NEM
  module NEM12
    class File
      attr_reader :csv, :file, :header, :footer, :nmis, :records

      def initialize(file)
        @file = file
        @csv = ::CSV.parse(file)
        @enumerator = @csv.each

        @records = []

        parse_header
        parse_body
      end

      def parse_header
        @header = Header.new(
          version_identifier: enumerator.peek[1],
          created_at: ActiveSupport::TimeZone[10].parse(enumerator.peek[2]),
          from_participant: enumerator.peek[3],
          to_participant: enumerator.peek[4]
        )
      end

      def parse_body
        while enumerator.peek[0] != "900"
          parse_row enumerator.next
        end
      rescue StopIteration
      end

      def parse_row(row)
        case row[0]
        when "200" then parse_data_detail(row)
        end
      end

      def parse_data_row(row, detail)
        case row[0]
        when "300" then parse_interval_data(row, detail)
        # when "400" then parse_interval_event(row, interval_length)
        # when "500" then parse_b2b_detail(row, interval_length)
        end
      end

      def where(options)
        records.select do |record|
          record.match?(options)
        end
      end

      def find(options)
        where(options).first
      end

      def parse_data_detail(row)
        options = DataDetail.row_to_hash(row, :nmi, :register_id, :nmi_suffix, :mdm_data_stream_identifier, :meter_serial_number, :unit_of_measure)
        detail = find(options)

        unless detail
          options = DataDetail.row_to_hash(
            row, :nmi, :register_id, :nmi_configuration, :nmi_suffix,
            :mdm_data_stream_identifier, :meter_serial_number,
            :unit_of_measure, :interval_length, :next_scheduled_read_on
          ).merge(records: [])

          detail = DataDetail.new(options)
          @records << detail
        end

        while enumerator.peek[0] != "200"
          parse_data_row(enumerator.next, detail)
        end
      end

      def parse_interval_data(row, detail)
        detail.records << IntervalData.new(IntervalData.row_to_hash(row, detail.interval_count, detail.interval_length))
      end

      def parse_interval_event(row)
        raise NotImplementedError.new("Not implemented yet")
      end

      def parse_b2b_detail(row)
        raise NotImplementedError.new("Not implemented yet")
      end

      private

      attr_reader :enumerator
    end
  end
end

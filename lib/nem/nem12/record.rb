module NEM
  module NEM12
    class Record
      include HashConstructed

      # The base class for all record types in the NEM12 format. This class
      # serves a base for all of the different record types and should not be
      # instantiated directly.

      # Returns the NEM12 indicator for this record
      # @return [Integer] the NEM12 indicator for this record
      def indicator
        case self.class.to_s
        when NEM::NEM12::Header.to_s
          100
        when NEM::NEM12::DataDetail.to_s
          200
        when NEM::NEM12::IntervalData.to_s
          300
        end
      end

      def self.row_to_hash(row, *columns)
        columns.each_with_object({}) do |field, hash|
          hash[field.to_sym] = row[fields[field]] if fields[field].present?
        end
      end

      # Returns the NEM12 indicator description for this record
      # @return [String] the NEM12 indicator description for this record
      def indicator_description
        NEM::NEM12::RECORD_INDICATORS[indicator]
      end
    end
  end
end

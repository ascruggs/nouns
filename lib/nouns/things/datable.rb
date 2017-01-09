module Nouns
  module Things
    module Datable

      def to_date(things_date)
        things_date == :missing_value ? nil : things_date
      end

    end
  end
end

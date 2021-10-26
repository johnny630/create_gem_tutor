module CreateGemTutor
  module DataRecord
    module Persistence
      def initialize(attributes = {})
        self.class.set_column_to_attribute
        @attributes = attributes
      end
    end
  end
end
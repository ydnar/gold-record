module GoldRecord
  module Fixtures
    def self.included(base)
      base.class_eval do
        class << self
          # Patch Fixtures.identify for binary UUIDs.
          def identify_with_padding(label)
            GoldRecord::UUID.pad_16(identify_without_padding(label))
          end
          alias_method_chain :identify, :padding
        end
      end
    end
  end
end

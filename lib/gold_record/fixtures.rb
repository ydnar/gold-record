module GoldRecord
  module Fixtures
    def self.included(base)
      base.class_eval do
        class << self
          # Patch Fixtures.identify for binary UUIDs.
          def identify_with_padding(label)
            ("%-16d" % identify_without_padding(label)).tr(" ", "\0")
          end
          alias_method_chain :identify, :padding
        end
      end
    end
  end
end

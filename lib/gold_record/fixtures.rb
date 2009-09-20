# Replace Fixtures.identify for binary UUIDs.
module GoldRecord
  module Fixtures
    def self.included(base)
      base.class_eval do
        def self.identify(label)
          UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, label.to_s).raw
        end
      end
    end
  end
end

module GoldRecord
  module RecordIdentifier
    def self.included(base)
      base.class_eval do
        class << self
          # Patch for binary UUIDs.
          def dom_id(record, prefix = nil) 
            if record_id = record.to_param
              "#{dom_class(record, prefix)}#{JOIN}#{record_id}"
            else
              dom_class(record, prefix || NEW)
            end
          end
        end
      end
    end    
  end
end

if Object.const_defined?("ActionController")
  ActionController::RecordIdentifier.send :include, GoldRecord::RecordIdentifier
  ActionController::Base.send :include, GoldRecord::RecordIdentifier
end

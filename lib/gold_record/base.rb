require 'active_record'
require 'uuidtools'

module GoldRecord
  module ClassMethods
    def gold_record?
      true
    end

    def find_one_with_uuid(id, options)
      find_one_without_uuid(GoldRecord::UUID.coerce(id), options)
    end

    def find_some_with_uuid(ids, options)
      ids = ids.map { |id| GoldRecord::UUID.coerce(id) }
      ids = ids.uniq # must do this after coercion
      find_some_without_uuid(ids, options)
    end
  end

  module InstanceMethods
    def to_uuid
      UUIDTools::UUID.parse_raw(id) rescue nil
    end
    
    def to_param
      (id = self.id) ? GoldRecord::UUID.encode_hex(id) : nil
    end

    def generate_id!
      self[self.class.primary_key] ||= GoldRecord::UUID.random_generate
    end
  end

  module ActMethods
    def acts_as_gold_record
      extend ClassMethods
      class << self
        alias_method_chain :find_one, :uuid
        alias_method_chain :find_some, :uuid
      end
      include InstanceMethods
      before_create :generate_id!
    end
  end
end

ActiveRecord::Base.extend GoldRecord::ActMethods

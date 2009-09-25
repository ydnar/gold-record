require 'uuidtools'

module GoldRecord
  module ClassMethods
    def gold_record?
      true
    end
    
    def coerce_id(id)
      if id.is_a?(String) && id.size == 16
        id
      else
        UUIDTools::UUID.parse(id).raw rescue nil
      end
    end

    def find_one_with_uuid(id, options)
      find_one_without_uuid(coerce_id(id), options)
    end

    def find_some_with_uuid(ids, options)
      ids = ids.map { |id| coerce_id(id) }
      ids = ids.uniq # must do this after coercion
      find_some_without_uuid(ids, options)
    end
  end

  module InstanceMethods
    def to_uuid
      UUIDTools::UUID.parse_raw(id) rescue nil
    end

    def to_param_with_uuid
      to_uuid.to_param
    end

    def generate_id!
      self[self.class.primary_key] ||= UUIDTools::UUID.random_create.raw
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
      alias_method_chain :to_param, :uuid
      before_create :generate_id!
    end
  end
end

ActiveRecord::Base.extend GoldRecord::ActMethods

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

    def find_one_with_coerce(id, options)
      find_one_without_coerce(coerce_id(id), options)
    end

    def find_some_with_coerce(ids, options)
      ids = ids.map { |id| coerce_id(id) }
      find_some_without_coerce(ids, options)
    end
  end

  module InstanceMethods
    def to_uuid
      UUIDTools::UUID.parse_raw(id.to_s)
    end

    def to_param
      to_uuid.to_param
    end

    def generate_id!
      self[self.class.primary_key] ||= UUIDTools::UUID.random_create.raw
    end
  end

  module ActMethods
    def acts_as_gold_record
      extend ClassMethods
      include InstanceMethods
      before_create :generate_id!
      class << self
        alias_method_chain :find_one, :coerce
        alias_method_chain :find_some, :coerce
      end
    end
  end
end

ActiveRecord::Base.extend GoldRecord::ActMethods

module GoldRecord
  class Base < ActiveRecord::Base
    acts_as_gold_record
  end
end

module BankCard
  module Validations
    class ExpirationValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        record.errors.add(attribute, :expired, options) unless value && value.end_of_month.future?
      end
    end

    module ClassMethods
      def validates_expiration_of(*attr_names)
        validates_with ExpirationValidator, _merge_attributes(attr_names)
      end
    end
  end
end


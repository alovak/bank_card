module BankCard
  module Validations
    class LuhnValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        relative_number = {'0' => 0, '1' => 2, '2' => 4, '3' => 6, '4' => 8, '5' => 1, '6' => 3, '7' => 5, '8' => 7, '9' => 9}

        sum = 0

        value.to_s.reverse.split("").each_with_index do |n, i|
        sum += (i % 2 == 0) ? n.to_i : relative_number[n]
        end

        unless sum % 10 == 0
          record.errors.add(attribute, :invalid, options)
        end
      end
    end
  end
end

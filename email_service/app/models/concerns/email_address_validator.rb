class EmailAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not a valid email") unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

# class EmailAddressValidator < ActiveModel::Validator
#   def validate(record)
#     if record.density > 20
#       record.errors.add(:density, “is too high to safely ship”)
#     end
#   end
# end
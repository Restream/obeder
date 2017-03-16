class RestreamEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@restream.rt.ru\z/i
      record.errors.add(attribute, :invalid_email)
    end
  end
end

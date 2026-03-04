# frozen_string_literal: true

class Types::NotifiableUnion < Types::BaseUnion
  possible_types Types::Comment

  def self.resolve_type(object, _context)
    case object
    when ::Comment
      Types::Comment
    else
      raise "Unknown Notifiable type: #{object.class}"
    end
  end
end

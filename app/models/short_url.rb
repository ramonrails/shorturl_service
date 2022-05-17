# frozen_string_literal: true

require 'securerandom'

#
# Model class
#
class ShortUrl < ApplicationRecord
  # validations at ORM layer
  # 
  # TODO: User submitted shortcodes must be at least 4 characters long.
  validates :shortcode, presence: true, length: { minimum: 4 }

  # NOTE: ORM callbacks
  # 
  before_validation :pre_validation

  #
  # class methods
  #
  class << self
    #
    # fetch by ID or shortcode
    #
    # @param [code] arg string
    #
    # @return [ShortUrl] record from database
    #
    def fetch(arg = nil)
      return ShortUrl.none if arg.blank?

      ShortUrl.where('id = :code OR shortcode = :code', code: arg).take
    end
  end

  #
  # private methods
  #
  private

    # runs validations just before sending record from ORM to database layer
    #
    # TODO: A user can submit a URL to /submit without a shortcode proposed, and receive automatically allocated unique shortcode in response.
    # TODO: A user can submit a URL to /submit with the desired shortcode and will receive the chosen shortcode if it is available.
    # TODO: All shortcodes can contain digits, upper case letters, and lowercase letters. It is case in-sensitive.
    def pre_validation
      # NOTE:
      # assigns only when blank
      # generates random 6 digit code
      # 
      # TODO: Automatically allocated shortcodes are exactly 6 characters long.
      self.shortcode = (shortcode.presence || SecureRandom.base36(6))
    end
end

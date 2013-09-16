require 'open-uri'

module Douglas; module NE; module Checks

  class File

    def initialize(uri)

      open(uri, 'r') do |file|

        # TODO: Actually make it work, easy.

      end

    end

  end

end; end; end

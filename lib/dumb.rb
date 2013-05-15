# extensions
class String
  def to_touchtones
    gsub(/[abc]/i, '2').
    gsub(/[def]/i, '3').
    gsub(/[ghi]/i, '4').
    gsub(/[jkl]/i, '5').
    gsub(/[mno]/i, '6').
    gsub(/[pqrs]/i, '7').
    gsub(/[tuv]/i, '8').
    gsub(/[wxyz]/i, '9')
  end

  def to_class_name
    capitalize.gsub(/[-_.\s]([a-zA-Z0-9])/) { $1.upcase }.gsub('+', 'x')
  end
end

module Dumbstore
  module AppContainer
    @@apps = {}

    def apps
      @@apps
    end

    def get id
      raise "AppNotFoundError" unless @@apps[id]
      @@apps[id].new
    end

    def register_app id, app_class
      @@apps[id] = app_class
    end
  end

  module Voice; extend AppContainer end
  module Text; extend AppContainer end

  class App
    # TODO flatten text_id/voice_id defs
    @text_id = nil
    def self.text_id *args
      if args.empty?
        @text_id
      else
        @text_id = args.first
      end
    end

    @voice_id = nil
    def self.voice_id *args
      if args.empty?
        @voice_id
      else
        @voice_id = args.first.to_touchtones
      end
    end

    def self.register!
      Dumbstore::Text.register_app self.text_id, self if self.text_id
      Dumbstore::Voice.register_app self.voice_id.to_touchtones, self if self.voice_id
    end

    def self.register_all!
      Dir['apps/*'].map do |filename|
        require_relative '../' + filename
        const_get(File.basename(filename, '.*').to_class_name).register!
      end
    end
  end
end
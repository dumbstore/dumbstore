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
    def apps
      @apps
    end

    def get id
      raise "AppNotFoundError" unless @apps[id]
      @apps[id].new
    end

    def register_app id, app_class
      @apps ||= {}
      @apps[id] = app_class
    end
  end

  module Voice; extend AppContainer end
  module Text; extend AppContainer end

  class App
    def self.app_property *props
      props.each do |prop|
        module_eval <<-EVAL
        @#{prop} = nil
        def self.#{prop} *args
          if args.empty?
            @#{prop}
          else
            @#{prop} = args.first
          end
        end
        EVAL
      end
    end
    
    app_property :text_id, :voice_id
    app_property :name, :author, :author_url, :url, :description

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
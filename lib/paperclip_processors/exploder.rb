module Paperclip
  class Exploder < Processor
    def initialize file, options = {}, attachment = nil
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @current_format = File.extname(@file.path)
      @basename       = File.basename(@file.path, @current_format)
    end

    def make
      src = @file
      dst = Tempfile.new([@basename, '.jpg'])
      dst.binmode

      begin
        parameters = []
        parameters << "-coalesce"
        parameters << ":source"
        parameters << "-append"
        parameters << ":dest"

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ") 
        success = convert(parameters, :source => File.expand_path(src.path), :dest => File.expand_path(dst.path))
      end

      dst
    end
  end
end
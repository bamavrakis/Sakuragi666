# lib/paperclip_processors/pdf_thumbnail.rb
module Paperclip
  class PdfThumbnail < Processor

    def initialize(file, options = {}, attachment = nil)
      super
      @file = file
      @instance = options[:instance]
      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
    end

    def make
      dst = Tempfile.new([@basename, 'jpg'].compact.join("."))
      dst.binmode
      pdf = ::Magick::ImageList.new(File.expand_path(@file.path))
      image = pdf[0..2].append(false)
      image.scale(340, 440)
      image.format = 'JPG'
      image.write(File.expand_path(dst.path))
      dst.flush
      return dst
    end
  end
end

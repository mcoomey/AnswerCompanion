# encoding: utf-8

class VideofileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # encoding: utf-8

   # version :mp4 do
   #     process :encode_video => [:mp4, "*** passed in to encode_video ***"]
   #     def full_filename(for_file)
   #       "#{File.basename(for_file, File.extname(for_file))}.mp4"
   #     end
   #   end
   #  
   #   version :webm do
   #     process :encode_video => [:webm, "*** passed in to encode_video ***"]
   #     def full_filename(for_file)
   #       "#{File.basename(for_file, File.extname(for_file))}.webm"
   #     end
   #   end
   #  
   #   version :ogv do
   #     process :encode_video => [:ogv, "*** passed in to encode_video ***"]
   #     def full_filename(for_file)
   #       "#{File.basename(for_file, File.extname(for_file))}.ogv"
   #     end
   #   end
    
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

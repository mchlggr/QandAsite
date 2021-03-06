class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  #上限変更
  process :resize_to_limit => [700, 700]
  #
  # def scale(width, height)
  #   # do something
  # end

  #サムネイルを生成
  version :thumb do
    process :resize_to_fill => [120, 120]
  end

  # miniアイコンを生成
  version :mini do
    process :resize_to_fill => [40, 40]
  end

  #JPGで保存
  process :convert => 'jpg'

  # jpg,jpeg,gif,pngのみ
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  #ファイル名を変更し拡張子を同じにする
  def filename
    super.chomp(File.extname(super)) + '.jpg' 
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #日付で保存
  def filename
    if original_filename.present?
      time = Time.now
      name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
      name.downcase
    end
  end

  def auto
    manipulate! do|image|
      image.auto_orient
    end
  end

  process :auto

end

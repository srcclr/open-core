Rails.application.config.assets.precompile += Dir[
  File.expand_path('../../../app/assets/fonts/**/*.[eot|svg|ttf|woff|woff2]', __FILE__)
]

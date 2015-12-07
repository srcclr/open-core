::SecureHeaders::Configuration.configure do |config|
  config.hsts = { max_age: 20.years.to_i, include_subdomains: true }
  config.x_frame_options = 'DENY'
  config.x_content_type_options = 'nosniff'
  config.x_xss_protection = { value: 1, mode: 'block' }
  config.x_download_options = 'noopen'
  config.x_permitted_cross_domain_policies = 'none'
  config.csp = {
    enforce: true,
    connect_src: 'self',
    default_src: 'none',
    font_src: 'self https://fonts.gstatic.com data:',
    img_src: 'self *.srcclr.com https://na-sjg.marketo.com https://avatars1.githubusercontent.com https://ssl.google-analytics.com',
    object_src: 'self',
    report_uri: 'https://open.srcclr.com/report-uri/fbbc4e69-facd-40b2-aff6-594d3734567c',
    script_src: 'self inline eval https://ssl.google-analytics.com',
    style_src: 'self inline'
  }
end

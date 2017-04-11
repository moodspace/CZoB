# vendor assets
Rails.application.config.assets.paths << Rails.root.join("vendor/assets")

%w( albums ).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end

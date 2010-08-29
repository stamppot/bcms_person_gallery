SPEC = Gem::Specification.new do |spec| 
  spec.name = "bcms_person_gallery"
  spec.rubyforge_project = spec.name
  spec.version = "1.0.2"
  spec.summary = "A Person Gallery Module for BrowserCMS"
  spec.author = "Jens Rasmussen" 
  spec.email = "stamppot@gmail.com"
  spec.homepage = "http://github.com/stamppot" 
  spec.files += Dir["app/**/*"]
  spec.files += Dir["public/bcms/bcms_persons/javascripts/*"]
  spec.files += Dir["db/migrate/*.rb"]
  spec.files -= Dir["db/migrate/*_browsercms_*.rb"]
  spec.files -= Dir["db/migrate/*_load_seed_data.rb"]
  spec.files += Dir["lib/bcms_person_gallery.rb"]
  spec.files += Dir["lib/bcms_person_gallery/*"]
  spec.files += Dir["rails/init.rb"]
  spec.files += Dir["db/seeds.rb"]
  spec.files += Dir["lib/tasks/seed_person_gallery_sample_data.rake"]
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README"]
end

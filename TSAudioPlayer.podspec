Pod::Spec.new do |s|
  s.name         = "TSAudioPlayer"
  s.version      = "0.0.1"
  s.summary      = "A AudioPlayer for steaming and persisting audio files"
  s.description  = <<-DESC
                   Downloads the audio file to disk as it is steamed, then lets you copy
                   the file so you can play it again later.
                   DESC
  s.homepage     = "https://github.com/laptobbe/TSAudioPlayer"
  s.license      = "MIT"
  s.author             = { "Tobias Sundstrand" => "tobias.sundstrand@gmail.com" }
  # s.platform     = :ios
  # s.platform     = :ios, "5.0"
  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  s.source       = { :git => "https://laptobbe@github.com/laptobbe/TSAudioPlayer.git", :commit => "54c78ee7853afd043dffbe82de87240e8f933ab9"}
  s.source_files  = "TSAudioPlayer/**/*.{h,m}"
  s.frameworks = "AudioToolbox"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
end

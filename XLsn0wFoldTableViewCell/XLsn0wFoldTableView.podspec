
Pod::Spec.new do |s|

  s.version         = "1.0.2"

  s.summary         = "XLsn0wFoldTableView"
  s.author          = { "XLsn0w" => "xlsn0w@outlook.com" }

  s.name            = "XLsn0wFoldTableView"
  s.homepage        = "https://github.com/XLsn0w/XLsn0wFoldTableView"
  s.source          = { :git => "https://github.com/XLsn0w/XLsn0wFoldTableView.git", :tag => s.version.to_s }

  s.source_files    = "XLsn0wFoldTableViewCell/**/*.{h,m}"

  s.frameworks      = "UIKit", "Foundation"

  s.requires_arc    = true
  s.license         = 'MIT'
  s.platform        = :ios, "8.0"

# s.dependency "XLsn0wKit_objc"

end

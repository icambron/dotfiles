#! /usr/bin/ruby

Dir.open(".").each do |f|
  next if f.length < 3 || f =~ /\.rb$|^\.git/
  source = File.expand_path("./#{f}")
  destination = File.expand_path("~/#{f}")
  puts "Linking #{source} to #{destination}"
  File.delete destination if File.symlink? destination
  File.symlink source, destination

end

`vim +BundleInstall +qall`
`cd .vim/bundle/vimproc.vim; make`

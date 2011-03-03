#!/usr/bin/env ruby

# Generates gallery pages by scanning for images in a certain file structure,
# and then lists the images newest first. Skips the 'life' gallery because
# that one has a certain non-chronological order that must be preserved by hand.

Dir.glob('*/img') {|dir|
    dir = dir.split('/')[0]
    next if dir == 'life'
    
    puts "Generating #{dir.capitalize} gallery."
    Dir.chdir dir
    
    file = File.new "index.html", "w"
    file.write <<"END_HEADER"
---
layout: gallery
title: #{dir.capitalize}
#{dir}: id="title"
---
END_HEADER
    images = Dir.glob('img/*.jpg').sort {|x,y| y <=> x}
    images.each {|img| file.write("<img src=\"#{img}\" />\n") }
    file.close
    Dir.chdir '..'
}

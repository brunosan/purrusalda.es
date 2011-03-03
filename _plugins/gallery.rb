# Usage: place this file into your jekyll _plugins directory. Then organize your
# photo files something like this:
#
# your_gallery_name/index.html
# your_gallery_name/img/YYYYMMDD-photo1.jpg
# your_gallery_name/img/YYYYMMDD-photo2.jpg
# your_gallery_name/img/YYYYMMDD-photo3.jpg
# your_gallery_name/img/YYYYMMDD-etc.jpg
#
# Your index.html should contain something like this:
#
#   ---
#   layout: any_layout_you_want
#   title: Your Title Here
#   ---
#   {% gallery your_gallery_name %}
#
# So the important point here is that 'your_gallery_name' in the liquid tag
# matches the directory name that contains the index.html file and the 'img'
# directory.

module Jekyll
    class GalleryTag < Liquid::Tag
        def initialize(tag_name, markup, tokens)
            @directory = markup.strip
            super
        end
        
        def render(context)
            Dir.chdir @directory
            result = []
            images = Dir.glob('*/*.jpg').sort {|x,y| y <=> x }
            images.each {|img| result << "<img src=\"#{img}\" />" }
            Dir.chdir '..'
            result.join "\n"
        end
    end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)


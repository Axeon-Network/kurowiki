# GalleryGen for KuroWiki (_plugins/gallery.rb)
# Copyright Axeon Network/Nekori 2025
Jekyll.logger.info "GalleryGen:", "Copyright Axeon Network/Nekori, 2025"

module Jekyll
  class GalleryTag < Liquid::Block
    def render(context)
      site = context.registers[:site]
      
      # FIX: Explicitly check for @nodelist and map only if it exists.
      # This reliably gets the raw content string and handles the error from 
      # the Liquid version you are running.
      
      nodelist = @nodelist.nil? ? [] : @nodelist
      
      gallery_content = nodelist.map do |node|
        # Render each node in the nodelist as a string
        if node.respond_to?(:render)
          node.render(context)
        else
          node.to_s
        end
      end.join.strip

      # If the block was empty or only whitespace, return immediately.
      return '' if gallery_content.empty?

      converter = site.find_converter_instance(Jekyll::Converters::Markdown)
      
      html = '<div class="wiki-gallery">'
      
      # Process each line after splitting by newline
      gallery_content.split(/\r?\n/).each do |line|
        trimmed_line = line.strip
        next if trimmed_line.empty?
        
        # Split image_src and caption at the first pipe (|)
        parts = trimmed_line.split('|', 2)
        next if parts.empty?
        
        image_src = parts[0].strip
        raw_caption = parts.length > 1 ? parts[1].strip : ''

        # Convert the caption text from Markdown to HTML
        if raw_caption.empty?
          caption_text = ''
        else
          caption_text = converter.convert(raw_caption).strip
          # Remove surrounding <p> tags that Markdown converter might add
          caption_text = caption_text.gsub(/^<p>(.*)<\/p>$/m, '\1')
        end
        
        # Use the Liquid Renderer to process the include file.
        include_html = site.liquid_renderer.lookup_and_render(
          'gallery_item.html',
          context.environments.first.merge({
            'include' => { 
              'image_src' => image_src,
              'alt_text' => raw_caption.gsub(/<[^>]*>/, '') , 
              'caption_html' => caption_text
            }
          })
        )
        
        html += include_html
      end
      
      html += '</div>'
      return html
    end
  end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)
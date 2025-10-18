require 'json'
require 'jekyll'
require 'fileutils'
Jekyll.logger.info "KuroWiki", "DeltaSearch, Version 2.3!"
Jekyll.logger.info "", "The generator for the search index in Deltari."
Jekyll.logger.info "", "..."
Jekyll.logger.info "", "I know im one version late but FIRE IN THE HOLE"
Jekyll.logger.info "Copyright Axeon Network/Nekori, 2025.", ""

Jekyll::Hooks.register :site, :post_write do |site|
  
  if site.config['serving']
    Jekyll.logger.info "DeltaSearch:", "Skipping write to source to prevent infinite loop during 'serve'."
    Jekyll.logger.info "", "Nekori, I know you needed this one.."
    next 
  end

  output_dir = File.join(site.source, 'resources', 'json')
  output_file_path = File.join(output_dir, 'search.json')
  
  FileUtils.mkdir_p(output_dir)
  Jekyll.logger.info "DeltaSearch:", "Created output directory: #{output_dir}"

  search_data_array = site.pages.reject do |page|
    exclude_manually = page.data['search_exclude']
    exclude_redirect = page.data['redirect_to']
    exclude_xml = page.url.end_with?('.xml') || page.url.end_with?('.json')
    exclude_manually || exclude_redirect || exclude_xml
  end.map do |page|
    cleaned_url = page.url.start_with?('/') ? page.url[1..-1] : page.url

    # Generate first-sentence snippet
    clean_content = page.content.gsub(/<[^>]*>/, '').strip
    match_data = clean_content.match(/(\.|\?|\!)\s|\n|$/)
    
    if match_data
      end_index = match_data.end(0)
      snippet = clean_content[0, end_index].strip
      unless snippet.end_with?('.', '?', '!')
        snippet += '...'
      end
    else
      snippet = clean_content.strip
      words = snippet.split(/\s+/)
      if words.length > 50
        snippet = words[0..49].join(' ') + '...'
      end
    end
    
    aliases = page.data['aliases']
    aliases_string = (aliases.is_a?(Array) ? aliases.join(' ') : aliases.to_s).downcase
    
    {
      'title' => page.data['title'].to_s,
      'url' => cleaned_url,
      'aliases' => aliases_string,
      'snippet' => snippet
    }
  end

  File.open(output_file_path, 'w') do |f|
    f.write(JSON.pretty_generate(search_data_array))
  end
  
  Jekyll.logger.info "DeltaSearch:", "Generated search index at: #{output_file_path}"
end
require 'json'
require 'jekyll'
require 'fileutils'
Jekyll.logger.info "KuroWiki", "DeltaSearch, Version 2.0!"
Jekyll.logger.info "", "The generator for the search index in Deltari."
Jekyll.logger.info "", "Copyright Axeon Network/Nekori, 2025."

Jekyll::Hooks.register :site, :post_write do |site|
  output_dir = File.join(site.source, 'resources', 'json')
  output_file_path = File.join(output_dir, 'search.json')
  
  FileUtils.mkdir_p(output_dir)
  Jekyll.logger.info "DeltaSearch:", "Created output directory: #{output_dir}"

  search_data_array = site.pages.reject { |page| page.data['search_exclude'] }.map do |page|
    cleaned_url = page.url.start_with?('/') ? page.url[1..-1] : page.url
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
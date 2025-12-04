require 'json'
require 'jekyll'
require 'fileutils'

Jekyll.logger.info "Axeon KuroWiki", "DeltaSearch, Version 2.4!"
Jekyll.logger.info "", "The generator for the search index in Deltari."
Jekyll.logger.info "", "Copyright Axeon Network/Nekori, 2025."

Jekyll::Hooks.register :site, :post_write do |site|
  # if jekyll is serving the site, do not write the new search index
  # to prevent an infinte loop  
  if site.config['serving']
    Jekyll.logger.info "DeltaSearch:", "Skipping write to source to prevent infinite loop during 'serve'."
    next 
  end

  output_dir = File.join(site.source, 'resources', 'json')
  output_file_path = File.join(output_dir, 'search.json')
  
  FileUtils.mkdir_p(output_dir)
  Jekyll.logger.info "DeltaSearch:", "Created output directory: #{output_dir}"

  # get configuration variables
  baseurl = site.config['baseurl'].to_s.chomp('/')
  
  # if prod, use the configured prod url
    url_prefix = baseurl
    Jekyll.logger.info "DeltaSearch:", "Using production prefix: #{url_prefix}"
    Jekyll.logger.info "", "If you want to use the compiled the search index for a debug build,"
    Jekyll.logger.info "", "simply go into resources/json/search.json and replace all instances of"
    Jekyll.logger.info "", "'axeon-network.github.io/kurowiki' to '127.0.0.1:4000' and you should be good to go!"

  # --------------------------------------------------------------------------

  search_data_array = site.pages.reject do |page|
    exclude_manually = page.data['search_exclude']
    exclude_redirect = page.data['redirect_from']
    exclude_xml = page.url.end_with?('.xml') || page.url.end_with?('.json')
    exclude_manually || exclude_redirect || exclude_xml
  end.map do |page|
    
    # Construct the full, correct URL path using the combined prefix.
    # page.url always starts with a '/' (e.g., '/about/').
    url_path = url_prefix + page.url

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
      # Use the new, full absolute path
      'url' => url_path, 
      'aliases' => aliases_string,
      'snippet' => snippet
    }
  end

  File.open(output_file_path, 'w') do |f|
    f.write(JSON.pretty_generate(search_data_array))
  end
  
  Jekyll.logger.info "DeltaSearch:", "Generated search index at: #{output_file_path}"
end

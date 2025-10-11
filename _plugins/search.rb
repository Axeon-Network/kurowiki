# DeltaSearch for the search engine (_plugins/search.rb)
# Copyright 2025 Axeon Network

require 'json'
require 'jekyll'
require 'fileutils' # Need FileUtils for mkdir_p
Jekyll.logger.info "DeltaSearch:", "Search engine for KuroWiki"
Jekyll.logger.info "", "Copyright Axeon Network/Nekori, 2025"

Jekyll::Hooks.register :site, :post_write do |site|
  # 1. Define the target output directory and file path
  output_dir = File.join(site.dest, 'resources', 'json')
  output_file_path = File.join(output_dir, 'search.json')
  
  # 2. Ensure the output directory exists
  # The mkdir_p method creates the directory and all necessary parent directories.
  FileUtils.mkdir_p(output_dir)
  Jekyll.logger.info "DeltaSearch:", "Created output directory: #{output_dir}"

  # Build the search data JSON
  search_data = site.pages.reject { |page| page.data['search_exclude'] }.map do |page|
    # Remove the leading slash from the URL
    cleaned_url = page.url.start_with?('/') ? page.url[1..-1] : page.url

    {
      'title' => page.data['title'].to_s,
      'url' => cleaned_url
    }
  end.to_json

  # 3. Write the JSON data to the new location
  File.open(output_file_path, 'w') do |f|
    f.write(search_data)
  end
  
  Jekyll.logger.info "DeltaSearch:", "Generated search index at: #{output_file_path}"
end
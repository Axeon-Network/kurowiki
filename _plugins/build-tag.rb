require 'time'
require 'jekyll'

module Jekyll
  class ExtBuildInfoGenerator < Generator
    safe true
    priority :highest
    Jekyll.logger.info "KuroWiki", "TagGen, Version 1.0.1!"
    Jekyll.logger.info "", "Who tagging they builds."
    Jekyll.logger.info "", "Copyright Axeon Network/Nekori, 2025"


    def generate(site)
      output_dir = File.join(site.source, 'resources', 'ruby')
      build_number_file_path = File.join(output_dir, 'version')
      build_tag_file_path = File.join(output_dir, 'buildtag')

      unless File.directory?(output_dir)
          FileUtils.mkdir_p(output_dir)
          Jekyll.logger.info "TagGen:", "Created output directory: #{output_dir}"
      end
		
      id = 'b6chk'

      lab = ''
      begin
        lab = `git rev-parse --abbrev-ref HEAD`.strip
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to get Git branch: #{e.message}. Using 'unknown'."
        lab = 'unknown'
      end

      current_incremental_number = 0
      begin
        if File.exist?(build_number_file_path)
          current_incremental_number = File.read(build_number_file_path).to_i
        else
          current_incremental_number = 4209
        end
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to read /resources/ruby/version: #{e.message}. Starting from 4210."
        current_incremental_number = 4209
      end

      current_incremental_number += 1

      begin
        File.write(build_number_file_path, current_incremental_number.to_s)
        Jekyll.logger.info "TagGen:", "Incremental build number persisted to disk: #{current_incremental_number}"
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to write /resources/ruby/version: #{e.message}. Build number not persisted."
      end

      timestamp = Time.now.strftime("%y%m%d-%H%M")

      buildtag = "6.0.#{current_incremental_number}.#{lab}.#{timestamp}"

      begin
        File.write(build_tag_file_path, buildtag)
        Jekyll.logger.info "TagGen:", "Full build tag persisted to disk: #{buildtag}"
      rescue => e
        Jekyll.logger.error "TagGen:", "Failed to write /resources/ruby/buildtag: #{e.message}. Build tag not persisted."
      end

      site.config['version'] = {
        'major' => 6,
        'minor' => 0,
        'id' => id,
        'build' => current_incremental_number,
        'lab' => lab,
        'timestamp' => timestamp,
        'full' => buildtag
      }

      Jekyll.logger.info "TagGen:", "Ext Build Info loaded into site.config: #{site.config['version'].inspect}"
    end
  end
end
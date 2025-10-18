require 'time'
require 'jekyll'

module Jekyll
  class ExtBuildInfoGenerator < Generator
    safe true
    priority :highest
    Jekyll.logger.info "KuroWiki", "TagGen, Version 1.0!"
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

      git_branch = ''
      begin
        git_branch = `git rev-parse --abbrev-ref HEAD`.strip
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to get Git branch: #{e.message}. Using 'unknown'."
        git_branch = 'unknown'
      end

      current_incremental_number = 0
      begin
        if File.exist?(build_number_file_path)
          current_incremental_number = File.read(build_number_file_path).to_i
        else
          current_incremental_number = 3765
        end
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to read /resources/ruby/version: #{e.message}. Starting from 3766."
        current_incremental_number = 3765
      end

      current_incremental_number += 1

      begin
        File.write(build_number_file_path, current_incremental_number.to_s)
        Jekyll.logger.info "TagGen:", "Incremental build number persisted to disk: #{current_incremental_number}"
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to write version.txt: #{e.message}. Build number not persisted."
      end

      timestamp = Time.now.strftime("%y%m%d-%H%M")

      full_build_tag = "6.0.#{current_incremental_number}.#{git_branch}.#{timestamp}"

      begin
        File.write(build_tag_file_path, full_build_tag)
        Jekyll.logger.info "TagGen:", "Full build tag persisted to disk: #{full_build_tag}"
      rescue => e
        Jekyll.logger.error "TagGen:", "Failed to write build_tag.txt: #{e.message}. Build tag not persisted."
      end

      site.config['version'] = {
        'major' => 6,
        'minor' => 0,
        'patch' => current_incremental_number,
        'branch' => git_branch,
        'timestamp' => timestamp,
        'full_tag' => full_build_tag
      }

      Jekyll.logger.info "TagGen:", "Ext Build Info loaded into site.config: #{site.config['version'].inspect}"
    end
  end
end
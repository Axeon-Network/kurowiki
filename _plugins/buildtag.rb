# TagGen for build tag generation (_plugins/buildtag.rb)
# Copyright 2025 Axeon Network

require 'time'
require 'jekyll'

module Jekyll
  class ExtBuildInfoGenerator < Generator
    safe true
    priority :highest
    Jekyll.logger.info "TagGen:", "Build Number Tag Generation"
    Jekyll.logger.info "", "Copyright Axeon Network/Nekori, 2025"


    def generate(site)
      # define paths
      output_dir = File.join(site.source, 'resources', 'ruby')
      build_number_file_path = File.join(output_dir, 'version')
      build_tag_file_path = File.join(output_dir, 'buildtag')

      
      # ensure the target directory exists before writing
      unless File.directory?(output_dir)
          FileUtils.mkdir_p(output_dir)
          Jekyll.logger.info "TagGen:", "Created output directory: #{output_dir}"
      end

      # get current git branch name
      git_branch = ''
      begin
        git_branch = `git rev-parse --abbrev-ref HEAD`.strip
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to get Git branch: #{e.message}. Using 'unknown'."
        git_branch = 'unknown'
      end

      # read and increment the build number
      current_incremental_number = 0
      begin
        if File.exist?(build_number_file_path)
          current_incremental_number = File.read(build_number_file_path).to_i
        else
          # if the file doesnt exist then start at 2003
          current_incremental_number = 2599
        end
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to read /resources/ruby/version: #{e.message}. Starting from 2600."
        current_incremental_number = 2599
      end

      current_incremental_number += 1

      # persist the new incremental number
      begin
        File.write(build_number_file_path, current_incremental_number.to_s)
        Jekyll.logger.info "TagGen:", "Incremental build number persisted to disk: #{current_incremental_number}"
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to write version.txt: #{e.message}. Build number not persisted."
      end

      # generate timestamp
      timestamp = Time.now.strftime("%y%m%d-%H%M")

      # create full build tag string
      full_build_tag = "5.2.#{current_incremental_number}.#{git_branch}.#{timestamp}"

      # persist full build tag to file
      begin
        File.write(build_tag_file_path, full_build_tag)
        Jekyll.logger.info "TagGen:", "Full build tag persisted to disk: #{full_build_tag}"
      rescue => e
        Jekyll.logger.error "TagGen:", "Failed to write build_tag.txt: #{e.message}. Build tag not persisted."
      end

      # add all build info to site.config variable
      site.config['version'] = {
        'major' => 5,
        'minor' => 2,
        'patch' => current_incremental_number,
        'branch' => git_branch,
        'timestamp' => timestamp,
        'full_tag' => full_build_tag
      }

      Jekyll.logger.info "TagGen:", "Ext Build Info loaded into site.config: #{site.config['version'].inspect}"
    end
  end
end
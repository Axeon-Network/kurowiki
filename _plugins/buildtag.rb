# Build tag generator (_plugins/buildtag.rb)
# Copyright 2025 Axeon Network

require 'time'
require 'jekyll'

module Jekyll
  class ExtBuildInfoGenerator < Generator
    safe true
    priority :highest

    def generate(site)
      # Define the paths for our build info files
      build_number_file_path = File.join(site.source, '.version')
      build_tag_file_path = File.join(site.source, '.buildtag')

      # Get the current Git branch name
      git_branch = ''
      begin
        git_branch = `git rev-parse --abbrev-ref HEAD`.strip
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to get Git branch: #{e.message}. Using 'unknown'."
        git_branch = 'unknown'
      end

      # Read and increment the build number
      current_incremental_number = 0
      begin
        if File.exist?(build_number_file_path)
          current_incremental_number = File.read(build_number_file_path).to_i
        else
          # If the file doesn't exist, start at 2003
          current_incremental_number = 2003
        end
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to read version.txt: #{e.message}. Starting from 2003."
        current_incremental_number = 2003
      end

      current_incremental_number += 1

      # Persist the new incremental number
      begin
        File.write(build_number_file_path, current_incremental_number.to_s)
        Jekyll.logger.info "TagGen:", "Incremental build number persisted to disk: #{current_incremental_number}"
      rescue => e
        Jekyll.logger.error "TagGen Error:", "Failed to write version.txt: #{e.message}. Build number not persisted."
      end

      # Generate the timestamp
      timestamp = Time.now.strftime("%y%m%d-%H%M")

      # Create the full build tag string
      full_build_tag = "4.3.#{current_incremental_number}.#{git_branch}.#{timestamp}"

      # Persist the full build tag to a file
      begin
        File.write(build_tag_file_path, full_build_tag)
        Jekyll.logger.info "TagGen:", "Full build tag persisted to disk: #{full_build_tag}"
      rescue => e
        Jekyll.logger.error "TagGen:", "Failed to write build_tag.txt: #{e.message}. Build tag not persisted."
      end

      # Add all the build info to the site.config variable
      site.config['version'] = {
        'major' => 4,
        'minor' => 3,
        'patch' => current_incremental_number,
        'branch' => git_branch,
        'timestamp' => timestamp,
        'full_tag' => full_build_tag
      }

      Jekyll.logger.info "TagGen:", "Ext Build Info loaded into site.config: #{site.config['ext_build_info'].inspect}"
    end
  end
end
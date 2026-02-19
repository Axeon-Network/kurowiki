require 'time'
require 'jekyll'
require 'etc' 

# tracker to prevent double banners
$axeon_banner_shown = false

# initial thing, only runs when jekyll server is first ran
Jekyll::Hooks.register :site, :after_init do |site|
  unless $axeon_banner_shown
    output_dir = File.join(site.source, 'resources', 'ruby')
    build_tag_file_path = File.join(output_dir, 'buildtag')
    
    dev_phase = site.config['devphase'] || "DUMMY"
    buildtag = File.exist?(build_tag_file_path) ? File.read(build_tag_file_path).strip : "LOADING..."

    puts "Pre-Release Axeon Kuro/Delta #{dev_phase}"
    puts "Axeon Deltari Build Tag Generator Code Named \"TagGen\", version 2.0"
    puts "Copyright 2025-2026 Axeon Network\n\n"
    
    $axeon_banner_shown = true
  end
end

module Jekyll
  class ExtBuildInfoGenerator < Generator
    safe true
    priority :highest

    def generate(site)
      output_dir = File.join(site.source, 'resources', 'ruby')
      build_number_file_path = File.join(output_dir, 'version')
      build_tag_file_path = File.join(output_dir, 'buildtag')
      FileUtils.mkdir_p(output_dir) unless File.directory?(output_dir)

      # git branch
      lab = ''
      begin
        lab = `git rev-parse --abbrev-ref HEAD`.strip
        raise if lab.empty? || lab.include?("fatal")
      rescue
        date_stub = Time.now.strftime("%y-%m-%d")
        user_stub = ENV['USERNAME'] || ENV['USER'] || Etc.getlogin || "dummy"
        lab = "#{date_stub}_#{user_stub}"
      end

      is_debug = site.config['debug'] == true
      current_incremental_number = 0
      buildtag = ""

      if is_debug
        is_regeneration = site.respond_to?(:regenerator)

        begin
          current_incremental_number = File.exist?(build_number_file_path) ? File.read(build_number_file_path).to_i : 4209
        rescue
          current_incremental_number = 4209
        end

        # only increment if we are actually regenerating
        if is_regeneration && $axeon_banner_shown
          current_incremental_number += 1
          File.write(build_number_file_path, current_incremental_number.to_s)
          
          timestamp = Time.now.strftime("%y%m%d-%H%M")
          buildtag = "7.0.#{current_incremental_number}.#{lab}.#{timestamp}"
          File.write(build_tag_file_path, buildtag)
          
          Jekyll.logger.info "", "Building Kuro/Delta ver #{buildtag}"
        else
          # just load the tag
          buildtag = File.exist?(build_tag_file_path) ? File.read(build_tag_file_path).strip : "7.0.#{current_incremental_number}.#{lab}.000000-0000"
        end
      else
        # in retail mode, dont increment anything, just load the last saved build
        if File.exist?(build_tag_file_path)
          buildtag = File.read(build_tag_file_path).strip
          current_incremental_number = buildtag.split('.')[2].to_i rescue 0
        else
          buildtag = "MJ.MN.BD.LB.DT-TM_DUMMY-TGEN"
          current_incremental_number = 0
        end
      end

      # site config writer
      site.config['version'] = {
        'major' => 7,
        'minor' => 0,
        'id' => 'rc1chk',
        'build' => current_incremental_number,
        'lab' => lab,
        'timestamp' => Time.now.strftime("%y%m%d-%H%M"),
        'full' => buildtag
      }
    end
  end
end

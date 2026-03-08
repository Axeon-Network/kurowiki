require 'time'
require 'jekyll'
require 'etc' 
require 'fileutils'

# tracker to prevent double banners
$axeon_banner_shown = false

Jekyll::Hooks.register :site, :after_init do |site|
  unless $axeon_banner_shown
    dev_phase = site.config['devphase'] || "DUMMY"
    puts "Debug Axeon Deltari \"Cairo\" #{dev_phase}"
    puts "Axeon Deltari Build Tag Generator Code Named \"TagGen\", version 2.5"
    puts "Copyright 2025-2026 Axeon Network. Developed by KitSixtyFour/StupidBiFox\n\n"
    $axeon_banner_shown = true
  end
end

Jekyll::Hooks.register :site, :after_reset do |site|
  output_dir = File.expand_path('resources/ruby', site.source)
  build_number_file_path = File.join(output_dir, 'version')
  build_tag_file_path = File.join(output_dir, 'buildtag')
  
  FileUtils.mkdir_p(output_dir) unless File.directory?(output_dir)

  # build lab
  lab = ''
  begin
    lab = `git rev-parse --abbrev-ref HEAD`.strip
    raise if lab.empty? || lab.include?("fatal")
  rescue
    date_stub = Time.now.strftime("%y-%m-%d")
    user_stub = ENV['USERNAME'] || ENV['USER'] || Etc.getlogin || "dummy"
    lab = "#{date_stub}_#{user_stub}"
  end

  if site.config['privatebuild'] == true
    current_user = ENV['USERNAME'] || ENV['USER'] || Etc.getlogin || "dummy"
    lab = "private/#{lab}(#{current_user})"
  end

  # ids
  is_debug = site.config['debug'] == true
  id_prefix = site.config['idprefix'] || "dp"
  id_suffix = is_debug ? "chk" : "fre"
  id_full = "#{id_prefix}#{id_suffix}"

  begin
    stored_number = File.exist?(build_number_file_path) ? File.read(build_number_file_path).to_i : 4209
  rescue
    stored_number = 4209
  end

  current_incremental_number = stored_number
  buildtag = ""

  if is_debug
    current_incremental_number += 1
    File.write(build_number_file_path, current_incremental_number.to_s)
    
    timestamp = Time.now.strftime("%y%m%d-%H%M")
    buildtag = "7.0.#{current_incremental_number}.#{id_full}.#{lab}.#{timestamp}"
    File.write(build_tag_file_path, buildtag)
    
    Jekyll.logger.info "", "Compiling Deltari \"Cairo\" #{current_incremental_number}.#{lab}.#{timestamp} for #{id_full}"
  else
        if File.exist?(build_tag_file_path)
          saved_tag = File.read(build_tag_file_path).strip
          parts = saved_tag.split('.')
          
          # grab the build number (index 2) and timestamp (last index)
          current_incremental_number = parts[2] || stored_number
          saved_timestamp = parts.last || "000000-0000"

          # reconstruct the string with the LIVE ID (fre) and Lab
          buildtag = "7.0.#{current_incremental_number}.#{id_full}.#{lab}.#{saved_timestamp}"
          File.write(build_tag_file_path, buildtag)
        else
          buildtag = "7.0.#{stored_number}.#{id_full}.#{lab}.000000-0000"
        end
      end

  # site configuration
  site.config['version'] = {
    'major' => 7,
    'minor' => 0,
    'id' => id_full,
    'build' => current_incremental_number,
    'lab' => lab,
    'timestamp' => buildtag.split('.').last,
    'full' => buildtag
  }
end
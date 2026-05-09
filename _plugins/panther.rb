require 'time'
require 'jekyll'
require 'etc' 
require 'fileutils'

# tracker to prevent double banners
$axeon_banner_shown = false

Jekyll::Hooks.register :site, :after_init do |site|
  unless $axeon_banner_shown
    dev_phase = site.config['devphase'] || "Developer Release"

    # version number config
    major = 7
    minor = 0
    
    if site.config['debug'] == true
	    type = "(Checked)"
    end
    if site.config['retail'] == true
      type = "(Retail)"
    end

    puts "Axeon KuroWiki #{dev_phase} #{type} [Version #{major}.#{minor}]"
    puts "               (C) 2025-2026 Axeon Network. All Rights Reserved.\n\n"
    puts "Panther Version Number Utility [Version 3.0.5001]"
    puts "               (C) 2025-2026 KitSixtyFour/StupidBiFox.\n\n"
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
  id = "#{id_prefix}#{id_suffix}"

  begin
    stored_number = File.exist?(build_number_file_path) ? File.read(build_number_file_path).to_i : 5186
  rescue
    stored_number = 5186
  end

  current_incremental_number = 5186
  buildtag = ""

  if is_debug
    current_incremental_number += 1
    File.write(build_number_file_path, current_incremental_number.to_s)
    

    major = 7
    minor = 0
    timestamp = Time.now.strftime("%y%m%d-%H%M")
    buildtag = "#{major}.#{minor}.#{current_incremental_number}.#{id}.#{lab}.#{timestamp}"
    File.write(build_tag_file_path, buildtag)
    
    Jekyll.logger.info "PANTHER:", "Loading Kuro #{current_incremental_number}.#{lab}.#{timestamp}"
  else
        if File.exist?(build_tag_file_path)
          saved_tag = File.read(build_tag_file_path).strip
          parts = saved_tag.split('.')
          
          # grab the build number (index 2) and timestamp (last index)
          current_incremental_number = parts[2] || stored_number
          saved_timestamp = parts.last || "000000-0000"

          # reconstruct the string with the LIVE ID (fre) and Lab
          buildtag = "#{major}.#{minor}.#{current_incremental_number}.#{id}.#{lab}.#{saved_timestamp}"
          File.write(build_tag_file_path, buildtag)
        else
          buildtag = "#{major}.#{minor}.#{stored_number}.#{id}.#{lab}.000000-0000"
        end
      end

  # site configuration
  site.config['version'] = {
    'major' => major,
    'minor' => minor,
    'id' => id,
    'build' => 5186,
    'lab' => lab,
    'timestamp' => buildtag.split('.').last,
    'full' => buildtag
  }
end

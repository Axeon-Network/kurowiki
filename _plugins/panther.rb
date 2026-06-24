# Axeon Panther (formerly TagGen)
# Copyright 2026 Axeon Network. Written with love by KitSixtyFour :3

require 'time'
require 'jekyll'
require 'etc' 
require 'fileutils'

# version number config
major = 7
minor = 0

# tracker to prevent double banners
$axeon_banner_shown = false

Jekyll::Hooks.register :site, :after_init do |site|
  unless $axeon_banner_shown
    dev_phase = site.config['devphase'] || "Gold Release"
    
    type = ""
    if site.config['debug'] == true
      type = "(Checked)"
    elsif site.config['retail'] == true
      type = "(Retail)"
    end

    puts "Axeon Akane Engine #{dev_phase} #{type} [Version #{major}.#{minor}]"
    puts "               (C) 2025-2026 Axeon Network. All Rights Reserved.\n"
    puts ""
    puts "Axeon Panther Version Master Utility [Version 4.0.5200]"
    puts "               (C) 2026 Axeon Network."
    puts "               Written by KitSixtyFour for the Axeon Network.\n\n"
    $axeon_banner_shown = true
  end
end

Jekyll::Hooks.register :site, :after_reset do |site|
  header_dir = File.expand_path('_includes', site.source)
  version_header_path = File.join(header_dir, 'misc', 'version.html')

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
  delta_enabled = site.config['builddelta'] == true
  id_prefix = site.config['idprefix'] || "dp"
  id_suffix = is_debug ? "chk" : "fre"
  id = "#{id_prefix}#{id_suffix}"

  stored_number = 5200
  delta_nbr = delta_enabled && is_debug ? 1 : 0

  current_delta = delta_nbr
  current_incremental_number = stored_number

  # Timestamp logic processing directly from version.html
  saved_timestamp = nil
  if File.exist?(version_header_path)
    existing_content = File.read(version_header_path)
    # Regex search to extract the old timestamp value from your generated Liquid statement
    if match = existing_content.match(/\{\%\s+assign\s+AKN_TIMESTAMP\s+=\s+"([^"]+)"\s+\%\}/)
      saved_timestamp = match[1]
    end
  end

  if is_debug
    # In Debug mode, always generate a live fresh build timestamp
    timestamp = Time.now.strftime("%y%m%d-%H%M")
    buildtag = "#{major}.#{minor}.#{current_incremental_number}.#{current_delta}.#{id}.#{lab}.#{timestamp}"
    Jekyll.logger.info "PANTHER:", "Loading Akane #{current_incremental_number}.#{current_delta} (#{lab}.#{timestamp})"
  else
    # In Retail/Release mode, reuse the old string if found, otherwise default it
    timestamp = saved_timestamp || "YYmmDD-HHss"
    buildtag = "#{major}.#{minor}.#{current_incremental_number}.#{current_delta}.#{id}.#{lab}.#{timestamp}"
  end

  # site configuration fallback exposure
  site.config['version'] = {
    'major' => major,
    'minor' => minor,
    'id' => id,
    'build' => current_incremental_number,
    'delta' => current_delta,
    'lab' => lab,
    'timestamp' => timestamp,
    'full' => buildtag
  }

  # Write directly to header file
  header_content = <<~HTML
    {% assign AKN_MAJOR = #{major} %}
    {% assign AKN_MINOR = #{minor} %}
    {% assign AKN_BUILD = #{current_incremental_number} %}
    {% assign AKN_DELTA = #{current_delta} %}
    {% assign AKN_ID = "#{id}" %}
    {% assign AKN_LAB = "#{lab}" %}
    {% assign AKN_TIMESTAMP = "#{timestamp}" %}
    {% assign AKN_VERSION = "#{buildtag}" %}
  HTML

  File.write(version_header_path, header_content)
end
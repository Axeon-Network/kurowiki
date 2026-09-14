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
    
    # Check Whidbey environment variable first, then fall back to site config context
    is_debug = ENV['WhdBuildType'] == 'chk' || (ENV['WhdBuildType'].nil? && site.config['debug'] == true)
    is_retail = ENV['WhdBuildType'] == 'fre' || (ENV['WhdBuildType'].nil? && site.config['retail'] == true)

    type = ""
    if is_debug
      type = "(Debug)"
    elsif is_retail
      type = "(Retail)"
    end

    hedDir = File.expand_path('_includes', site.source)
    verHed = File.join(hedDir, 'misc', 'version.html')

    prevBUILD = nil
    prevDELTA = nil

    # Read the file only once if it exists
    if File.exist?(verHed)
      existing_content = File.read(verHed)
      
      # Match integers or strings, with or without quotes
      if match1 = existing_content.match(/\{\%\s+assign\s+AKN_BUILD\s+=\s+["']?([^"'\s\%]+)["']?\s+\%\}/)
        prevBUILD = match1[1]
      end

      if match2 = existing_content.match(/\{\%\s+assign\s+AKN_DELTA\s+=\s+["']?([^"'\s\%]+)["']?\s+\%\}/)
        prevDELTA = match2[1]
      end
    end

    puts "Axeon Akane Codenamed Cairo Version #{major}.#{minor} (Build #{prevBUILD}.#{prevDELTA}: #{dev_phase}) #{type}"
    puts "              (C) 2025-2026 Axeon Network. All Rights Reserved.\n"
    puts ""
    puts "Axeon Panther Version Tracker Utility [Version 4.0.5200]"
    puts "              (C) 2026 Axeon Network."
    puts "              Written by KitSixtyFour for the Axeon Network.\n\n"
    $axeon_banner_shown = true
  end
end

Jekyll::Hooks.register :site, :after_reset do |site|
  header_dir = File.expand_path('_includes', site.source)
  version_header_path = File.join(header_dir, 'misc', 'version.html')

  # parse the whidbey vars
  if ENV['WhdBuildType'] == 'chk'
    site.config['debug'] = true
    site.config['retail'] = false
  elsif ENV['WhdBuildType'] == 'fre'
    site.config['debug'] = false
    site.config['retail'] = true
  end

  if ENV['WhdIsDeltaEnabled'] == 'no'
    site.config['builddelta'] = false
  elsif ENV['WhdIsDeltaEnabled'] == 'yes'
    site.config['builddelta'] = true
  end

  if ENV['WhdPrivateBuild'] == 'yes'
    site.config['privatebuild'] = true
  elsif ENV['WhdPrivateBuild'] == 'no'
    site.config['privatebuild'] = false
  end

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

  # read any vars made by whidbey to set debug/retail mode
  is_debug = site.config['debug'] == true
  delta_enabled = site.config['builddelta'] == true
  private_build = site.config['privatebuild'] == true

  if private_build
    current_user = ENV['USERNAME'] || ENV['USER'] || Etc.getlogin || "dummy"
    lab = "private/#{lab}(#{current_user})"
  end

  # ids
  id_prefix = site.config['idprefix'] || "dp"
  id_suffix = is_debug ? "chk" : "fre"
  id = "#{id_prefix}#{id_suffix}"

  stored_number = 5200
  delta_nbr = delta_enabled && is_debug ? 1 : 0

  current_delta = delta_nbr
  current_incremental_number = stored_number

  saved_timestamp = nil
  if File.exist?(version_header_path)
    existing_content = File.read(version_header_path)
    if match = existing_content.match(/\{\%\s+assign\s+AKN_TIMESTAMP\s+=\s+"([^"]+)"\s+\%\}/)
      saved_timestamp = match[1]
    end
  end

  if is_debug
    timestamp = Time.now.strftime("%y%m%d-%H%M")
    buildtag = "#{major}.#{minor}.#{current_incremental_number}.#{current_delta}.#{id}.#{lab}.#{timestamp}"
    Jekyll.logger.info "PANTHER:", "Loading Cairo #{current_incremental_number}.#{current_delta} (#{lab}.#{timestamp})"
  else
    # in retail mode, just used whatever the last saved thing was
    timestamp = saved_timestamp || "YYmmDD-HHss"
    buildtag = "#{major}.#{minor}.#{current_incremental_number}.#{current_delta}.#{id}.#{lab}.#{timestamp}"
  end

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
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
    isDebug = ENV['WhdBuildType'] == 'chk' || (ENV['WhdBuildType'].nil? && site.config['debug'] == true)
    isRetail = ENV['WhdBuildType'] == 'fre' || (ENV['WhdBuildType'].nil? && site.config['retail'] == true)

    type = ""
    if isDebug
      type = "Debug"
    elsif isRetail
      type = "Retail"
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

    puts "Axeon Quartz Software Code Named \"Cairo\" (#{type}) [Version #{major}.#{minor}.#{prevBUILD}.#{prevDELTA}]"
    puts "              (C) 2025-2026 Axeon Network. All Rights Reserved.\n"
    puts ""
    puts "Axeon Panther Version Tracker Utility [Version 4.0.5400]"
    puts "              (C) 2026 Axeon Network."
    puts "              Written by KitSixtyFour for the Axeon Network.\n\n"
    $axeon_banner_shown = true
  end
end


Jekyll::Hooks.register :site, :after_reset do |site|
  workingDir = File.expand_path('_includes', site.source)
  verHedPath = File.join(workingDir, 'misc', 'version.html')

  # Parse previous build, delta, and timestamp from existing version file safely
  prevBUILD = 5199
  prevDELTA = 0
  timestpSaved = nil

  if File.exist?(verHedPath)
    existing_content = File.read(verHedPath)
    
    if match1 = existing_content.match(/\{\%\s+assign\s+PNT_BUILD\s+=\s+["']?([^"'\s\%]+)["']?\s+\%\}/)
      prevBUILD = match1[1].to_i
    end

    if match2 = existing_content.match(/\{\%\s+assign\s+PNT_DELTA\s+=\s+["']?([^"'\s\%]+)["']?\s+\%\}/)
      prevDELTA = match2[1].to_i
    end

    if match3 = existing_content.match(/\{\%\s+assign\s+PNT_TIMESTAMP\s+=\s+"([^"]+)"\s+\%\}/)
      timestpSaved = match3[1]
    end
  end

  # Parse Whidbey environment variables and site config
  isDebug = ENV['WhdBuildType'] == 'chk' || (ENV['WhdBuildType'].nil? && site.config['debug'] == true)
  isRetail = ENV['WhdBuildType'] == 'fre' || (ENV['WhdBuildType'].nil? && site.config['retail'] == true)

  if ENV['WhdBuildType'] == 'chk'
    site.config['debug'] = true
    site.config['retail'] = false
    isDebug = true
    isRetail = false
  elsif ENV['WhdBuildType'] == 'fre'
    site.config['debug'] = false
    site.config['retail'] = true
    isDebug = false
    isRetail = true
  end

  deltaEnabled = site.config['builddelta'] == true
  if ENV['WhdIsDeltaEnabled'] == 'no'
    site.config['builddelta'] = false
    deltaEnabled = false
  elsif ENV['WhdIsDeltaEnabled'] == 'yes'
    site.config['builddelta'] = true
    deltaEnabled = true
  end

  isBuildPrivate = site.config['privatebuild'] == true
  if ENV['WhdPrivateBuild'] == 'yes'
    site.config['privatebuild'] = true
    isBuildPrivate = true
  elsif ENV['WhdPrivateBuild'] == 'no'
    site.config['privatebuild'] = false
    isBuildPrivate = false
  end

  # Build lab detection
  lab = ''
  begin
    lab = `git rev-parse --abbrev-ref HEAD`.strip
    raise if lab.empty? || lab.include?("fatal")
  rescue
    date_stub = Time.now.strftime("%y-%m-%d")
    user_stub = ENV['USERNAME'] || ENV['USER'] || Etc.getlogin || "dummy"
    lab = "#{date_stub}_#{user_stub}"
  end

  if isBuildPrivate
    userCur = ENV['USERNAME'] || ENV['USER'] || Etc.getlogin || "dummy"
    lab = "private/#{lab}(#{userCur})"
  end

  # IDs configuration
  idPref = site.config['idprefix'] || "dp"
  idSuf = isDebug ? "chk" : "fre"
  id = "#{idPref}#{idSuf}"

  # Build number logic: increment if non-retail, keep fixed if retail
  currentIncNum = isRetail ? prevBUILD : (prevBUILD + 1)
  deltaNum = deltaEnabled && isDebug ? 1 : 0
  deltaCur = deltaNum

  if isDebug
    timestamp = Time.now.strftime("%y%m%d-%H%M")
    buildtag = "#{major}.#{minor}.#{currentIncNum}.#{deltaCur}.#{id}.#{lab}.#{timestamp}"
    Jekyll.logger.info "PANTHER:", "Image Info: Axeon Quartz #{currentIncNum}.#{deltaCur} (#{lab}.#{timestamp})"
  else
    # In retail mode, keep the timestamp and build number fixed to the last saved values
    timestamp = timestpSaved || Time.now.strftime("%y%m%d-%H%M")
    buildtag = "#{major}.#{minor}.#{currentIncNum}.#{deltaCur}.#{id}.#{lab}.#{timestamp}"
  end

  header_content = <<~HTML
    {% assign PNT_MAJOR = #{major} %}
    {% assign PNT_MINOR = #{minor} %}
    {% assign PNT_BUILD = #{currentIncNum} %}
    {% assign PNT_DELTA = #{deltaCur} %}
    {% assign PNT_ID = "#{id}" %}
    {% assign PNT_LAB = "#{lab}" %}
    {% assign PNT_TIMESTAMP = "#{timestamp}" %}
    {% assign PNT_VERSION = "#{buildtag}" %}
  HTML

  File.write(verHedPath, header_content)
end
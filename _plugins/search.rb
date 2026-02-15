require 'json'
require 'jekyll'
require 'fileutils'

Jekyll::Hooks.register :site, :after_init, priority: :low do |site|
  Jekyll.logger.info "Axeon KuroWiki", "DeltaSearch version 2.4"
  Jekyll.logger.info "", "Copyright (C) 2025/26 Axeon Network"
  Jekyll.logger.info "", "Developed by KitSixtyFour."
  Jekyll.logger.info "", ""
  Jekyll.logger.info "WARNING:", "DeltaSearch will be deprecated in future releases of "
  Jekyll.logger.info "", "KuroWiki/Deltari in favor of Liquid-based syntaxes."
  Jekyll.logger.info "", "Please avoid use of this component as soon as possible"
  Jekyll.logger.info "", "to avoid any bugs."
end
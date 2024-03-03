local status, jdtls = pcall(require, 'jdtls')

if not status then
  return
end

local jdtls_config = require 'l.lsp.java'

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(jdtls_config)

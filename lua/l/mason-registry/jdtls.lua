local Package = require 'mason-core.package'

local timestamp = '202402151717'
local launcher_version = '1.6.700.v20231214-2017'

return Package.new {
  schema = 'registry+v1',
  name = 'jdtls',
  description = 'Java language server.',
  desc = 'Java language server.',
  homepage = 'https://github.com/eclipse/eclipse.jdt.ls',
  licenses = {
    'EPL-2.0',
  },
  languages = {
    'Java',
  },
  categories = {
    'LSP',
  },
  source = {
    id = 'pkg:generic/eclipse/eclipse.jdt.ls@v1.33.0',
    download = {
      {
        target = {
          'darwin_x64',
          'darwin_arm64',
        },
        files = {
          ['jdtls.tar.gz'] = 'https://download.eclipse.org/jdtls/milestones/{{ version | strip_prefix "v" }}/jdt-language-server-{{ version | strip_prefix "v" }}-'
            .. timestamp
            .. '.tar.gz',
          ['lombok.jar'] = 'https://projectlombok.org/lombok-edge.jar',
        },
        config = 'config_mac/',
      },
      {
        target = 'linux',
        files = {
          ['jdtls.tar.gz'] = 'https://download.eclipse.org/jdtls/milestones/{{ version | strip_prefix "v" }}/jdt-language-server-{{ version | strip_prefix "v" }}-'
            .. timestamp
            .. '.tar.gz',
          ['lombok.jar'] = 'https://projectlombok.org/lombok-edge.jar',
        },
        config = 'config_linux/',
      },
      {
        target = 'win',
        files = {
          ['jdtls.tar.gz'] = 'https://download.eclipse.org/jdtls/milestones/{{ version | strip_prefix "v" }}/jdt-language-server-{{ version | strip_prefix "v" }}-'
            .. timestamp
            .. '.tar.gz',
          ['lombok.jar'] = 'https://projectlombok.org/lombok-edge.jar',
        },
        config = 'config_win/',
      },
    },
  },
  schemas = {
    lsp = 'vscode:https://raw.githubusercontent.com/redhat-developer/vscode-java/master/package.json',
  },
  bin = {
    jdtls = 'python:bin/jdtls',
  },
  share = {
    ['jdtls/lombok.jar'] = 'lombok.jar',
    ['jdtls/plugins/'] = 'plugins/',
    ['jdtls/plugins/org.eclipse.equinox.launcher.jar'] = 'plugins/org.eclipse.equinox.launcher_' .. launcher_version .. '.jar',
    ['jdtls/config/'] = '{{source.download.config}}',
  },
}

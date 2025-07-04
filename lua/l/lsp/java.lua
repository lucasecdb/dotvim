local status, jdtls = pcall(require, 'jdtls')

if not status then
  return
end

local home_dir = os.getenv 'HOME'

local java_home = os.getenv 'JAVA_HOME'

local jdtls_bin = vim.fn.exepath 'jdtls'

local local_lombok = vim.fn.expand '$MASON/share/jdtls/lombok.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home_dir .. '/.workspace/' .. project_name

vim.fn.mkdir(workspace_dir, 'p')

local root_markers = { 'gradlew', '.git', 'mvnw', 'settings.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local bundles = {}

vim.list_extend(bundles, vim.fn.globpath('$MASON/share/vscode-java-decompiler/bundles', '*.jar', true, true))

vim.list_extend(bundles, vim.fn.globpath('$MASON/share/java-debug-adapter', '*.jar', true, true))

vim.list_extend(bundles, vim.fn.globpath('$MASON/share/java-test', '*.jar', true, true))

local config = {
  cmd = {
    jdtls_bin,
    '--jvm-arg=-Dlog.protocol=true',
    '--jvm-arg=-Dlog.level=ALL',
    '--jvm-arg=-javaagent:' .. local_lombok,
    '-data',
    workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      home = java_home,
      format = {
        enabled = false,
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = '~/.sdkman/candidates/java/21.0.4-tem/',
          },
          {
            name = 'JavaSE-17',
            path = '~/.sdkman/candidates/java/17.0.12-tem/',
          },
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
    settings = {
      java = {
        imports = {
          gradle = {
            wrapper = {
              checksums = {
                { sha256 = '81a82aaea5abcc8ff68b3dfcb58b3c3c429378efd98e7433460610fecd7ae45f', allowed = true },
                { sha256 = '7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172', allowed = true },
              },
            },
          },
        },
      },
    },
  },

  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    vim.keymap.set('n', '<leader>df', jdtls.test_class, { buffer = bufnr, desc = '[D]ebug [F]ull' })
    vim.keymap.set('n', '<leader>dn', jdtls.test_nearest_method, { buffer = bufnr, desc = '[D]ebug [N]earest Method' })
  end,
}

return config

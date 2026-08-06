local jdtls = require 'jdtls'

local options = require 'l.lsp.options'

local home_dir = os.getenv 'HOME'

local java_home = os.getenv 'JAVA_HOME'

local local_lombok = vim.fn.expand '$MASON/share/jdtls/lombok.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home_dir .. '/.workspace/' .. project_name

vim.fn.mkdir(workspace_dir, 'p')

local bundles = {}

vim.list_extend(bundles, vim.fn.globpath('$MASON/share/vscode-java-decompiler/bundles', '*.jar', true, true))

vim.list_extend(bundles, vim.fn.globpath('$MASON/share/java-debug-adapter', '*.jar', true, true))

vim.list_extend(bundles, vim.fn.globpath('$MASON/share/java-test', 'com.microsoft.java.test.plugin-*.jar', true, true))

return {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. local_lombok,
    '-data',
    workspace_dir,
  },

  filetypes = { 'java' },

  root_markers = { 'gradlew', '.git', 'mvnw', 'settings.gradle' },

  settings = {
    java = {
      home = java_home,
      format = {
        enabled = false,
      },
      settings = {
        url = home_dir .. '/.vim/jdt.prefs',
      },
      import = {
        gradle = {
          arguments = { '--no-parallel' },
          wrapper = { enabled = false },
          version = '8.14',
          java = {
            home = java_home,
          },
        },
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = '~/.sdkman/candidates/java/21.0.4-tem/',
          },
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },

  on_attach = function(client, bufnr)
    options.on_attach(client)

    vim.keymap.set('n', '<leader>df', jdtls.test_class, { buffer = bufnr, desc = '[D]ebug [F]ull' })
    vim.keymap.set('n', '<leader>dn', jdtls.test_nearest_method, { buffer = bufnr, desc = '[D]ebug [N]earest Method' })
  end,
}

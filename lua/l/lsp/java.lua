local fn = vim.fn

local home_dir = os.getenv('HOME')
local jdtls_cache_dir = home_dir .. '/.cache/jdtls'
local workspace_dir = jdtls_cache_dir .. '/workspace'
local config_dir = jdtls_cache_dir .. '/config'
local gradle_install_dir = home_dir .. '/.gradle/caches/modules-2/files-2.1'

local file_exists = function(path)
    local f = io.open(path, 'r')
    return f ~= nil and io.close(f)
end

local get_jar_for_lib = function(class)
    local classpath, name = unpack(vim.split(class, ":"))

    local lib_dir = string.format('%s/%s/%s', gradle_install_dir, classpath,
                                  name)
    local lib_versions = io.popen('ls -1 "' .. lib_dir .. '" | sort -r')

    if lib_versions == nil then return '' end

    local i, versions = 0, {}
    for version in lib_versions:lines() do
        i = i + 1
        versions[i] = version
    end
    lib_versions:close()

    if next(versions) == nil then return '' end

    local jar = fn.expand(string.format('%s/%s/*/%s-%s.jar', lib_dir,
                                        versions[1], name, versions[1]))

    if not file_exists(jar) then return '' end

    return string.format('--jvm-arg=-javaagent:%s', jar)
end

local libs_with_java_agent = {'org.projectlombok:lombok'}

local get_cmd = function()
    local cmd = {'jdtls'}

    for _, lib in ipairs(libs_with_java_agent) do
        local java_agent = get_jar_for_lib(lib)
        if (java_agent ~= '') then table.insert(cmd, java_agent) end
    end

    -- See `data directory configuration` section in the README
    table.insert(cmd, '-configuration')
    table.insert(cmd, config_dir)

    table.insert(cmd, '-data')
    table.insert(cmd, workspace_dir)

    return cmd
end

return {
    cmd = get_cmd(),
    settings = {
        java = {
            home = os.getenv("JAVA_HOME"),
            import = {gradle = {annotationProcessing = {enabled = true}}}
        }
    }
}

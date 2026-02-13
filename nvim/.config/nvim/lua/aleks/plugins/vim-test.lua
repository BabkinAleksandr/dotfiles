-- Helper function to find Kotlin test method and class (including nested classes)
local function find_kotlin_test()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Search backward for test method (backtick or regular)
    local method_name = nil
    local method_line = nil
    for i = current_line, 1, -1 do
        local line = lines[i]
        -- Check for backtick method: fun `method name`()
        local backtick_match = line:match("fun%s+`([^`]+)`")
        if backtick_match then
            method_name = backtick_match
            method_line = i
            break
        end
        -- Check for regular method: fun methodName()
        local regular_match = line:match("fun%s+([%w_]+)%s*%(")
        if regular_match then
            method_name = regular_match
            method_line = i
            break
        end
        -- Stop if we hit a class declaration
        if line:match("^%s*class%s+") or line:match("^%s*inner%s+class%s+") or line:match("^%s*object%s+") then
            break
        end
    end

    -- Build class hierarchy by tracking indentation and class declarations
    local class_stack = {}
    local current_indent = -1

    for i = 1, (method_line or current_line) do
        local line = lines[i]
        -- Get indentation level (number of leading spaces/tabs)
        local indent = #(line:match("^(%s*)") or "")

        -- Check for class or inner class declaration
        local class_match = line:match("^%s*class%s+([%w_]+)") or line:match("^%s*inner%s+class%s+([%w_]+)")
        local object_match = line:match("^%s*object%s+([%w_]+)")
        local match = class_match or object_match

        if match then
            -- Pop classes that are at same or higher indentation (we've exited them)
            while #class_stack > 0 and class_stack[#class_stack].indent >= indent do
                table.remove(class_stack)
            end
            -- Push this class
            table.insert(class_stack, { name = match, indent = indent })
        end
    end

    -- Build the full class name with $ separator for nested classes
    local full_class_name = nil
    if #class_stack > 0 then
        local names = {}
        for _, c in ipairs(class_stack) do
            table.insert(names, c.name)
        end
        full_class_name = table.concat(names, "$")
    end

    return full_class_name, method_name
end

-- Find the gradle project directory (contains build.gradle.kts or build.gradle)
local function find_gradle_project()
    local file_path = vim.fn.expand("%:p:h")
    local path = file_path

    while path ~= "/" do
        if
            vim.fn.filereadable(path .. "/build.gradle.kts") == 1
            or vim.fn.filereadable(path .. "/build.gradle") == 1
        then
            return path
        end
        path = vim.fn.fnamemodify(path, ":h")
    end
    return nil
end

-- Find root project (contains settings.gradle.kts or gradlew)
local function find_root_project()
    local file_path = vim.fn.expand("%:p:h")
    local path = file_path

    while path ~= "/" do
        if vim.fn.filereadable(path .. "/gradlew") == 1 then
            return path
        end
        path = vim.fn.fnamemodify(path, ":h")
    end
    return nil
end

local function run_kotlin_test_nearest()
    local class_name, method_name = find_kotlin_test()
    local gradle_project = find_gradle_project()
    local root_project = find_root_project()

    if not class_name then
        print("Could not find test class")
        return
    end

    if not root_project then
        print("Could not find Gradle root project")
        return
    end

    local test_filter
    if method_name then
        test_filter = class_name .. "." .. method_name
    else
        test_filter = class_name
    end

    -- Build the command
    local cmd = "cd " .. root_project .. " && ./gradlew test --tests '" .. test_filter .. "'"

    -- Add project path if it's a subproject
    if gradle_project and gradle_project ~= root_project then
        local relative_path = gradle_project:sub(#root_project + 2)
        cmd = "cd "
            .. root_project
            .. " && ./gradlew :"
            .. relative_path:gsub("/", ":")
            .. ":test --tests '"
            .. test_filter
            .. "'"
    end

    -- Run in terminal
    vim.cmd("vert rightbelow split | terminal " .. cmd)
    vim.cmd("normal! G")
end

local function run_kotlin_test_file()
    local class_name, _ = find_kotlin_test()
    local gradle_project = find_gradle_project()
    local root_project = find_root_project()

    if not class_name then
        print("Could not find test class")
        return
    end

    if not root_project then
        print("Could not find Gradle root project")
        return
    end

    -- Get only the outer class for file-level test
    local outer_class = class_name:match("^([^$]+)")
    local escaped_class = outer_class:gsub("%$", "\\$")

    local cmd
    if gradle_project and gradle_project ~= root_project then
        local relative_path = gradle_project:sub(#root_project + 2)
        cmd = "cd "
            .. root_project
            .. " && ./gradlew :"
            .. relative_path:gsub("/", ":")
            .. ':test --tests "'
            .. escaped_class
            .. '"'
    else
        cmd = "cd " .. root_project .. ' && ./gradlew test --tests "' .. escaped_class .. '"'
    end

    vim.cmd("vert rightbelow split | terminal " .. cmd)
    vim.cmd("normal! G")
end

-- Store last test command for re-running
local last_test_cmd = nil

local function run_kotlin_test_nearest_with_save()
    local class_name, method_name = find_kotlin_test()
    local gradle_project = find_gradle_project()
    local root_project = find_root_project()

    if not class_name then
        print("Could not find test class")
        return
    end

    if not root_project then
        print("Could not find Gradle root project")
        return
    end

    local test_filter
    if method_name then
        test_filter = class_name .. "." .. method_name
    else
        test_filter = class_name
    end

    -- Escape $ for shell (nested classes use $)
    local escaped_filter = test_filter:gsub("%$", "\\$")

    local cmd
    if gradle_project and gradle_project ~= root_project then
        local relative_path = gradle_project:sub(#root_project + 2)
        cmd = "cd "
            .. root_project
            .. " && ./gradlew :"
            .. relative_path:gsub("/", ":")
            .. ':test --tests "'
            .. escaped_filter
            .. '"'
    else
        cmd = "cd " .. root_project .. ' && ./gradlew test --tests "' .. escaped_filter .. '"'
    end

    last_test_cmd = cmd
    vim.cmd("vert rightbelow split | terminal " .. cmd)
    vim.cmd("normal! G")
end

local function run_last_test()
    if last_test_cmd then
        vim.cmd("vert rightbelow split | terminal " .. last_test_cmd)
        vim.cmd("normal! G")
    else
        print("No previous test to run")
    end
end

return {
    "vim-test/vim-test", -- Keep as dependency for other languages
    keys = {
        { "<leader>tr", run_kotlin_test_nearest_with_save, desc = "Run nearest test" },
        { "<leader>tf", run_kotlin_test_file, desc = "Run current file tests" },
        { "<leader>tl", run_last_test, desc = "Run last test" },
        {
            "<leader>td",
            function()
                local class_name, method_name = find_kotlin_test()
                print("Class: " .. (class_name or "nil") .. ", Method: " .. (method_name or "nil"))
            end,
            desc = "Debug: show detected test",
        },
    },
    config = function()
        -- Keep vim-test config for non-Kotlin files
        vim.g["test#strategy"] = "neovim"
        vim.g["test#neovim#term_position"] = "vert"
        vim.g["test#neovim#start_normal"] = 1
    end,
}

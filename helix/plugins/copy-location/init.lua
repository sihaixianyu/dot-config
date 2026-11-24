local copy_from_project = [[
file=$1
directory=${file%/*}
directory=${directory:-/}
root=$directory

while :; do
    if [ -e "$directory/.git" ] || [ -e "$directory/.jj" ] ||
       [ -e "$directory/.svn" ] || [ -e "$directory/.helix" ]; then
        root=$directory
        break
    fi
    [ "$directory" = / ] && break
    directory=${directory%/*}
    directory=${directory:-/}
done

relative_path=${file#"${root%/}/"}
printf '%s:%s' "$relative_path" "$2" | pbcopy 2>/dev/null
]]

local function shell_quote(value)
    return "'" .. value:gsub("'", "'\"'\"'") .. "'"
end

-- The keymap runs :pipe-to directly because this build cannot call it from Lua.
local command_register = "λ"
local previous_register

local function prepare_copy_location()
    previous_register = helix.editor.get_register(command_register)
    helix.editor.set_register(command_register, { ":" })

    local buffer = helix.buffer.get_current()
    local path = buffer:get_path()
    if not path then
        helix.ui.warn("Current buffer has no file path")
        return
    end

    local cursor = buffer:get_cursor()
    for _, range in ipairs(buffer:get_selections()) do
        local first = math.min(range.anchor, range.head)
        local last = math.max(range.anchor, range.head)
        if first <= cursor and (cursor < last or first == cursor and first == last) then
            local start_line = buffer:char_to_line(first) + 1
            local end_line = buffer:char_to_line(math.max(first, last - 1)) + 1
            local lines = tostring(start_line)
            if end_line ~= start_line then
                lines = lines .. "-" .. end_line
            end

            local command = table.concat({
                "sh -c", shell_quote(copy_from_project), "copy-location",
                shell_quote(path), lines,
            }, " ")
            helix.editor.set_register(command_register, { command })
            return
        end
    end
end

helix.register_command({
    name = "copy-location-prepare",
    doc = "Prepare the copy-location shell command",
    handler = prepare_copy_location,
})

helix.register_command({
    name = "copy-location-restore",
    doc = "Restore the register used by copy-location",
    handler = function()
        if previous_register then
            helix.editor.set_register(command_register, previous_register)
            previous_register = nil
        end
    end,
})

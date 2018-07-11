script_name = 'Duplicate and comment'
script_description = 'Duplicate the selected line, comment the original line and select the duplicated line.'
script_version = '1.0.0'
script_author = 'Albireo'

function process_macro(subtitles, selected_lines, active_line)
    local selected_line_index = selected_lines[1]
    local selected_line = subtitles[selected_line_index]
    subtitles.insert(selected_line_index + 1, selected_line)
    selected_line.comment = true
    subtitles[selected_line_index] = selected_line
    aegisub.set_undo_point(script_name)
    return { selected_line_index + 1 }
end

function validate_macro(subtitles, selected_lines, active_line)
    local count = 0
    for _ in pairs(selected_lines) do
        count = count + 1
    end
    if count == 0 then
        return false, 'No line has been selected.'
    elseif count == 1 then
        return true
    else
        return false, 'More than one line has been selected.'
    end
end

aegisub.register_macro(script_name, script_description, process_macro, validate_macro)

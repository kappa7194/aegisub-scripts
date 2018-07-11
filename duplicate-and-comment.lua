--[[
    Copyright 2018 Albireo

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
]]

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

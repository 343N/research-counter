require('mod-gui')

-- local researchIngredients = {}
-- local researchList = {}

-- script.on_load(refreshResearch)
script.on_init(function()
    checkButtonExistence()
end)
script.on_configuration_changed(function()
    refreshResearch()
end)
script.on_event(defines.events.on_player_joined_game, function()
    refreshResearch()
end)
-- script.on_init(checkButtonExistence)

function checkButtonExistence(p)
    if (p) then
        local flow = mod_gui.get_button_flow(p)
        -- create stuffs heres
    else
        
        for k, v in pairs(game.players) do
            local flow = mod_gui.get_button_flow(v)
            if (flow['research-counter-button']) then
                goto CONTINUE
            end
            -- create stuffs heres
            flow.add({
                name = 'research-counter-button',
                type = 'sprite-button',
                style = 'mod_gui_button',
                sprite = 'item/automation-science-pack',
                -- caption = "Open Research Counter",
                tooltip = { 'research-counter.modguibutton-tooltip' }
            })
            -- first time using goto OMEGALUL
            ::CONTINUE::
        end
    end
end

function buildGUI(ply)
    if (not ply) then
        return
    end

    if (table_size(global) == 0) then
        refreshResearch()
    end

    local base = ply.gui.screen

    local frame = base.add({
        name = 'research-counter-base',
        caption = { 'research-counter.gui-frame-title' },
        style = "inner_frame_in_outer_frame",
        direction = "vertical",
        -- tooltip = "Research Counter",
        type = "frame"
    })

    frame.style.minimal_width = 460
    frame.style.minimal_height = 348

    frame.force_auto_center()
    
    frame.style.horizontally_stretchable = true
    frame.style.vertically_stretchable = true
    -- local WIDTH = 412 + 25;
    -- local HEIGHT = 200 + 170;
    -- local res = ply.display_resolution
    -- local scl = ply.display_scale
    -- frame.location = {
    --     (res.width / 2) - ((WIDTH / 2) * scl),
    --     (res.height / 2) - ((HEIGHT / 2) * scl)
    -- }

    local tabbedPaneFrame = frame.add({
        name = "tabbedpaneFrame",
        type = 'frame',
        style = "inside_deep_frame_for_tabs"
    })

    tabbedPaneFrame.style.top_padding = 0

    local tabbedPane = tabbedPaneFrame.add({
        name = 'tabbedPane',
        type = "tabbed-pane",
        style = 'filter_tabbed_pane'
    })

    -- local tabbedPaneHeightCompensation = 52
    tabbedPane.style.horizontally_stretchable = true
    tabbedPane.style.vertically_stretchable = true
    -- tabbedPane.style.height = 250
    table.print(tabbedPane.children_names)
    -- print(tabbedPane.children_names)
    -- tabbedPane.style.left_padding = 8
    -- tabbedPane.style.right_padding = 8
    -- tabbedPane.style.top_padding = 8
    -- tabbedPane.style.bottom_padding = 8

    local individualTab = tabbedPane.add({
        name = "individual-tab",
        type = 'tab',
        caption = {"research-counter.individual-tab-title"},
        -- horizontally_stretchable = true,
    })
    local groupedTab = tabbedPane.add({
        name = "grouped-tab",
        type = 'tab',
        -- caption = "Grouped",
        caption = {"research-counter.grouped-tab-title"},
        -- horizontally_stretchable = true,
    })

    individualTab.style.horizontally_stretchable = true
    groupedTab.style.horizontally_stretchable = true
    
    individualTab.style.width = 218
    groupedTab.style.width = 218

    local individualScrollPane = tabbedPane.add({
        name = "individual-scroll-pane",
        type = 'scroll-pane',
        style = 'filter_scroll_pane'
    })
    local groupedScrollPane = tabbedPane.add({
        name = "grouped-scroll-pane",
        type = 'scroll-pane',
        style = 'filter_scroll_pane'
    })

    individualScrollPane.vertical_scroll_policy = 'always'
    individualScrollPane.horizontal_scroll_policy = 'never'
    individualScrollPane.style.left_margin = 12

    individualScrollPane.style.horizontally_stretchable = true
    individualScrollPane.style.vertically_stretchable = true
    
    individualScrollPane.style.left_padding = 0
    individualScrollPane.style.right_padding = 0
    individualScrollPane.style.right_margin = 12
    individualScrollPane.style.extra_right_padding_when_activated = -12
    individualScrollPane.style.extra_top_padding_when_activated = 0
    individualScrollPane.style.extra_bottom_padding_when_activated = 0
    -- individualScrollPane.style.left_margin = 0

    

    groupedScrollPane.vertical_scroll_policy = 'always'
    groupedScrollPane.horizontal_scroll_policy = 'never'
    groupedScrollPane.style.left_margin = 12

    groupedScrollPane.style.horizontally_stretchable = true
    groupedScrollPane.style.vertically_stretchable = true
    
    groupedScrollPane.style.left_padding = 0
    groupedScrollPane.style.right_padding = 0
    groupedScrollPane.style.right_margin = 12
    groupedScrollPane.style.extra_right_padding_when_activated = -12
    groupedScrollPane.style.extra_top_padding_when_activated = 0
    groupedScrollPane.style.extra_bottom_padding_when_activated = 0
    

    
    local individualFrame = individualScrollPane.add({
        name = "individual-tab-content-frame",
        type = 'frame',
        style = 'filter_scroll_pane_background_frame'
    })

    individualFrame.style.horizontally_stretchable = true
    individualFrame.style.vertically_stretchable = true
    individualFrame.style.minimal_width = 400
    individualFrame.style.minimal_height = 200
    individualFrame.style.top_padding = 0
    individualFrame.style.bottom_padding = 0
    

    local groupedFrame = groupedScrollPane.add({
        name = "grouped-tab-content-frame",
        type = 'frame',
        style = 'inner_frame_in_outer_frame'
    })

    groupedFrame.style.horizontally_stretchable = true
    groupedFrame.style.vertically_stretchable = true
    groupedFrame.style.minimal_width = 400
    groupedFrame.style.minimal_height = 200
    groupedFrame.style.right_margin = 12
    groupedFrame.style.top_padding = 0
    groupedFrame.style.bottom_padding = 0
    groupedFrame.style.left_padding = 0
    groupedFrame.style.right_padding = 0


    local individualTable = individualFrame.add({
        name = 'table',
        type = 'table',
        style = 'filter_slot_table',
        column_count = 10
    })

    local groupedTable = groupedFrame.add({
        name = 'table',
        type = 'table',
        style = 'filter_slot_table',
        column_count = 1
    })

    groupedTable.draw_horizontal_lines = true

    groupedTable.style.horizontally_stretchable = true
    groupedTable.style.vertically_stretchable = true
    groupedTable.style.horizontal_align = "center"
    groupedTable.style.vertical_align = "center"
    groupedTable.style.vertical_spacing = 1
    groupedTable.style.horizontal_spacing = 0
    groupedTable.style.margin = -4


    -- here is where we populate the GUI with interesting stuff

    local counts = {
        individual = {},
        group = {}
    }


    -- populate keys for individual ingredients table

    for k,v in pairs(global.researchIngredients.byID) do 
        if (v.enabled) then
            counts.individual[v] = 0
        end
    end
    
    -- count individual ingredients
    for k,v in pairs(ply.force.technologies) do
        -- counts.individual[ing.name] = 0
        if (shouldCountTech(v)) then  
            for _, ing in pairs(v.research_unit_ingredients) do
                counts.individual[ing.name] = v.research_unit_count + (counts.individual[ing.name] or 0)
            end
        end
    end

    -- populate and count table for grouped ingredients

    for groupName,group in pairs(global.allTechnologies.byIngredientGroup) do
        if (#groupName > 0) then
            counts.group[groupName] = 0
            for _, tech in pairs(group) do
                local plyTech = ply.force.technologies[tech.name]
                if (plyTech and shouldCountTech(plyTech)) then
                    counts.group[groupName] = tech.ingredientCount + counts.group[groupName]
                end
            end
        end
    end

    print("Research Counter: Generated player research count table..")

    -- populate indvidual GUI table

    for k,v in pairs(counts.individual) do
        individualTable.add({
            name = k,
            number = v,
            type = 'sprite-button',
            style = 'slot_button',
            sprite = 'item/' .. k,
            tooltip = { 
                "research-counter.individual-entry-tooltip",
                game.item_prototypes[k].localised_name, formatNumberString(v) 
            },
        })
    end

    for k,v in pairs(counts.group) do 
        local entry = groupedTable.add({
            name = k,
            type = "flow",
            direction = "horizontal"
            
        })
        entry.style.horizontally_stretchable = true
        entry.style.height = 40
        entry.style.vertical_align = "center"
        entry.style.left_padding = 4
        entry.style.right_padding = 4

        
        local iconFlow = entry.add({
            name = 'buttonFlow',
            type = 'flow',
            direction = 'horizontal'
        })
        iconFlow.style.horizontally_stretchable = true
        iconFlow.style.vertically_stretchable = true
        iconFlow.style.vertical_align = 'center'
        iconFlow.style.top_padding = 2
        iconFlow.style.bottom_padding = 2
        iconFlow.style.left_padding = 4
        iconFlow.style.right_padding = 4

        local count = 0
        for k2,v2 in pairs(global.researchIngredients.byGroupString[k]) do
            
            local sprite = iconFlow.add({
                name = v2,
                type = 'sprite',
                sprite = 'item/' .. v2,
                tooltip = game.item_prototypes[v2].localised_name,
                -- style = 'transparent_slot'
            })
            if (count ~= 0) then
                sprite.style.left_margin = -20
            end
            count = count + 1
        end
        
        for i=#iconFlow.children, 1, -1 do
            iconFlow.children[i].focus()
        end

        local labelFlow = entry.add({
            name = 'labelFlow',
            type = 'flow',
            direction = 'horizontal'
        })
        labelFlow.add({
            name = 'label',
            type = 'label',
            caption = {'research-counter.grouped-entry-label', formatNumberString(v)}
        })
        labelFlow.style.horizontal_align = "left"
        labelFlow.style.vertical_align = "center"
        labelFlow.style.vertically_stretchable = true

        labelFlow.style.width = 150
        labelFlow.style.left_padding = 4
        
        -- local line = groupedTable.add({
        --     name = 'line-' .. i,
        --     type = 'line',
        --     direction = 'horizontal'
        -- })
        

    end



    
    individualTable.style.horizontally_stretchable = true
    individualTable.style.vertically_stretchable = true
    groupedFrame.style.horizontally_stretchable = true
    groupedFrame.style.vertically_stretchable = true
    -- individualFrame.style.width = 402
    -- individualFrame.style.bottom_margin = 4
    -- individualFrame.style.width = 10
    -- individualFrame.style.height = 200
    -- individualFrame.style.height = 10

    local closeButton = frame.add({
        name = "research-counter-close-button",
        caption = {"research-counter.gui-close-button"},
        type  = "button"
    })

    -- groupedFrame.style.width = 426
    -- groupedFrame.style.width = 10
    -- groupedFrame.style.height = 250 - tabbedPaneHeightCompensation
    -- groupedFrame.style.height = 10
    

    tabbedPane.add_tab(individualTab, individualScrollPane)
    tabbedPane.add_tab(groupedTab, groupedScrollPane)
    print("GUI done!")
end

function toggleGUI(ply)

    if (getGUI(ply) and getGUI(ply).valid) then
        getGUI(ply).destroy()
    else
        buildGUI(ply)
    end

end

function shouldCountTech(tech)
    return (not tech.researched) and tech.enabled and (not tech.research_unit_count_formula)
end

script.on_event(defines.events.on_console_chat, function()
    if (__DebugAdapter) then
        print("Research Counter: DEBUG LOL")
    end
end)

script.on_event(defines.events.on_gui_click, function(e)
    local ply = game.players[e.player_index]
    print("Pressed!")
    if (e.element.name == 'research-counter-button') then
        toggleGUI(ply)
    end
    if (e.element.name == 'research-counter-close-button') then
        getGUI(ply).destroy()
    end

end)

function getGUI(ply)
    return ply.gui.screen['research-counter-base']
end

function refreshResearch()

    if (not game) then
        return
    end

    global.allTechnologies = {
        byName = {},
        byIngredient = {},
        byIngredientGroup = {}
    }
    global.researchIngredients = {
        byName = {},
        byID = {},
        byGroupString = {},
        groupStringOrder = {},
        groupStringOrderIndex = {}
    }

    local count = 1
    for k, v in pairs(game.forces.player.technologies) do

        local tech = {
            name = k,
            enabled = v.enabled,
            researched = v.researched,
            upgrade = v.upgrade,
            ingredientCount = v.research_unit_count,
            energy = v.research_unit_energy,
            ingredients = {},
            ingredientsIndex = {},
            isInfinite = tobool(v.research_unit_count_formula)
        }

        for k2, v2 in pairs(v.research_unit_ingredients) do
            local ingredientID = global.researchIngredients.byName[v2.name]
            if (not ingredientID) then
                ingredientID = count
                global.researchIngredients.byName[v2.name] = ingredientID
                global.researchIngredients.byID[ingredientID] = v2.name
                count = count + 1;
            end
            tech.ingredients[v2.name] = ingredientID
            tech.ingredientsIndex[ingredientID] = v2.name

        end

        tech.sortedIngredients = getSortedIngredientList(tech)
        tech.ingredientString = getIngredientString(tech)
        global.researchIngredients.byGroupString[tech.ingredientString] =
            global.researchIngredients.byGroupString[tech.ingredientString] or tech.ingredients
        -- global.researchIngredients.byGroupString[tech.ingredientString] = tech.ingredientString

        -- add technology to each technology list
        global.allTechnologies.byName[k] = tech
        for k, v in pairs(tech.ingredients) do
            if (not global.allTechnologies.byIngredient[k]) then
                global.allTechnologies.byIngredient[k] = {}
            end
            table.insert(global.allTechnologies.byIngredient[k], tech)
        end
        -- global.allTechnologies.byIngredientGroup[tech.ingredientString] =
        --     global.allTechnologies.byIngredientGroup[tech.ingredientString] or {}
        -- table.insert(global.allTechnologies.byIngredientGroup[tech.ingredientString], tech)
        -- ------------------------------------------------------------------------

    end

    buildIngredientGroupTables()

    
    print("Research Counter: Building Global Research Ingredient Tables!")
    -- print("Research Counter: Refreshed due to configuration change.")

end

function getSortedIngredientList(tech)

    if (tech.sortedIngredients) then
        return tech.sortedIngredients
    end

    if (tech.research_unit_ingredients) then
        local ingredientsList = {}
        for k, v in pairs(tech.research_unit_ingredients) do
            ingredientsList[global.researchIngredients.byName[v.name]] = true
        end
        return ingredientsList
    end

    if (tech.ingredients) then
        local ingredientsList = {}
        for k, v in pairs(tech.ingredients) do
            ingredientsList[global.researchIngredients.byName[k]] = true
        end
        return ingredientsList
    end

end

function getIngredientString(tech)
    local str = ""

    local sortedList = getSortedIngredientList(tech)
    for k, v in pairs(sortedList) do
        str = str .. k .. '/'
    end
    str = string.sub(str, 0, -2)
    -- string = string.sub
    return str
end

script.on_nth_tick(300, function()
    if (table_size(global) == 0) then 
        refreshResearch() 
    end
    checkButtonExistence()
    -- game.print("Checking shit")
end)

function tobool(a)
    return not not a
end

function buildIngredientGroupTables()
    local tbl = {}
    local index = {}
    -- build list of ingredient strings
    local count = 0
    for k, v in pairs(global.allTechnologies.byName) do
        if (not index[v.ingredientString]) then
            count = count + 1
            index[v.ingredientString] = count
            table.insert(tbl, v.ingredientString)
        end
    end


    table.sort(tbl, compareIngredientStrings)

    global.researchIngredients.groupStringOrder = tbl
    global.researchIngredients.groupStringOrderIndex = table.flip(tbl)

    global.researchIngredients.byGroupString = {}
    global.allTechnologies.byIngredientGroup = {}
    for k, v in pairs(tbl) do
        local ingTable = {}
        local splitIng = v:split('%d+')
        for k2, v2 in pairs(splitIng) do
            table.insert(ingTable, global.researchIngredients.byID[tonumber(v2)])
        end
        global.researchIngredients.byGroupString[v] = ingTable
        global.allTechnologies.byIngredientGroup[v] = {}
    end

    for k, v in pairs(global.allTechnologies.byName) do
        table.insert(global.allTechnologies.byIngredientGroup[v.ingredientString], v)
    end

    print("Research Counter: Building Ingredient Group Tables!")

end

function compareIngredientStrings(a, b)

    local aNil = (a == nil)
    local bNil = (b == nil)
    -- local notb = not b
    if (a == nil) then return false end
    if (b == nil) then return true end
    a = a:split('%d+')
    b = b:split('%d+')

    local iterations = math.min(#a, #b)
    for i = 1, iterations do
        local numA = tonumber(a[i])
        local numB = tonumber(b[i])
        if (numA ~= numB) then
            return numA < numB
        elseif (i == iterations) then
            return #a < #b;
        end
    end

end

function splitString(str, delim, rightToLeft)
    print("Splitting string...")
    local tbl = {}
    if (type(delim) == 'number') then
        if (rightToLeft) then
            for i=#str, 1, -delim do
                local substr = str:sub(math.max(i - delim + 1, 1), i)
                print('i:' .. i)
                print('i - delim:' .. i - delim)
                print('substring of '.. i - delim ..' to '.. i ..': ' .. substr)
                table.insert(tbl, substr)
            end
        else
            for i=1, #str, delim do
                table.insert(tbl, str:sub(i, i + delim - 1))
            end
        end
    elseif (type(delim) == 'string') then
        local iteratorFunc = str:gmatch(delim)
        local str = iteratorFunc()
        while (str) do
            table.insert(tbl, str)
            str = iteratorFunc()
        end

    end

    return tbl
end

function table.reverse(tbl)
    local newtbl = {}
    for i=#tbl, 1, -1 do
        newtbl[#tbl - i + 1] = tbl[i]
    end
    return newtbl
end

-- not recursive
function table.flip(tbl)
    local newtbl = {}
    for k, v in pairs(tbl) do
        newtbl[v] = k
    end

    return newtbl
end


function table.print(tbl, indent, printFunc)
    local printFunc = printFunc or print
    printFunc("Printing Table (" .. table_size(tbl) .. " keys)")
    local indent = indent or 0
    local indStr = ""
    for i = 1, indent do
        indStr = indStr .. '  '
    end
    for k, v in pairs(tbl) do
        printFunc(indStr .. k .. ': ' .. tostring(v))
        if (type(v) == "table") then
            table.print(v, indent + 1)
        end
    end
end

function formatNumberString(str)
    str = tostring(str)
    local newstr = table.concat(table.reverse(str:split(3, true)), ',')
    return newstr
end

getmetatable("").__index['split'] = splitString

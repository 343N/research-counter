local style = util.table.deepcopy(data.raw["gui-style"]["default"]["filter_tabbed_pane"])

style.tab_content_frame.left_padding = 0

local stylename = "researchcounter_tabbed_pane"
data.raw["gui-style"]["default"][stylename] = style
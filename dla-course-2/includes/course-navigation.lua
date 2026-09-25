local stages = {
  {"index", "Start"}, {"understand", "Understand"},
  {"spreadsheet-essentials", "Spreadsheet Essentials"}, {"build", "Build"},
  {"test", "Test"}, {"decide", "Decide"}, {"reflect", "Reflect"}
}
function Div(el)
  local page = quarto.doc.input_file:match("([^/]+)%.qmd$")
  local current
  for i, stage in ipairs(stages) do if stage[1] == page then current = i end end
  if el.identifier == "course-progress" then
    local html = '<nav class="stage-progress" aria-label="Course progress">'
    for i, stage in ipairs(stages) do
      local active = i == current and ' class="active" aria-current="page"' or ''
      html = html .. '<a data-progress-page="' .. stage[1] .. '" href="' .. stage[1] .. '.html"' .. active .. '>' .. stage[2] .. '</a>'
    end
    return pandoc.RawBlock('html', html .. '</nav><span id="learning-content" tabindex="-1"></span>')
  elseif el.identifier == "course-page-nav" then
    local html = '<nav class="iframe-nav app-nav" aria-label="Page navigation">'
    if current and current > 1 then
      local prev = stages[current - 1]
      html = html .. '<a class="course-button alt" href="' .. prev[1] .. '.html">← Previous: ' .. prev[2] .. '</a>'
    end
    if current and current < #stages then
      local next = stages[current + 1]
      html = html .. '<a class="course-button" href="' .. next[1] .. '.html">Next: ' .. next[2] .. ' →</a>'
    else
      html = html .. '<a class="course-button alt" href="index.html">Return to Start</a>'
    end
    return pandoc.RawBlock('html', html .. '</nav>')
  end
end

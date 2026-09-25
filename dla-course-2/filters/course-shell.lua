-- Render navigation once from a single ordered journey; works without JavaScript.
local stages = {
  {'index', 'Start'}, {'understand', 'Understand'},
  {'spreadsheet-essentials', 'Spreadsheet Essentials'}, {'build', 'Build'},
  {'test', 'Test'}, {'decide', 'Decide'}, {'reflect', 'Reflect'}
}
function Pandoc(doc)
  local page = pandoc.utils.stringify(doc.meta['course-page'])
  local current
  for i, stage in ipairs(stages) do if stage[1] == page then current = i end end
  local title = pandoc.utils.stringify(doc.meta.title)
  local context = current and ('Stage ' .. current .. ' of 7 · ' .. stages[current][2]) or 'Course design · Reviewer notes'
  local parts = {'<a class="skip-link" href="#course-content">Skip to lesson</a><div class="embed-utility"><a href="index.html" target="_blank" rel="noopener">Open course in new window ↗</a></div>', '<nav class="course-journey" aria-label="Course journey"><details open><summary>' .. context .. '<span class="journey-toggle">View stages</span></summary><ol class="stage-progress">'}
  for i, stage in ipairs(stages) do
    local state = current and i < current and 'previous' or ''
    local active = i == current and ' aria-current="page"' or ''
    table.insert(parts, '<li class="' .. state .. '"><a href="' .. stage[1] .. '.html" data-progress-page="' .. stage[1] .. '"' .. active .. '><span class="stage-number" aria-hidden="true">' .. i .. '</span><span>' .. stage[2] .. '</span>' .. (i == current and '<span class="visually-hidden"> (current stage)</span>' or '') .. '</a></li>')
  end
  table.insert(parts, '</ol></details></nav><header class="course-heading" id="course-content" tabindex="-1"><p class="course-kicker">' .. context .. '</p><h1>' .. title .. '</h1><p class="lead">' .. pandoc.utils.stringify(doc.meta['course-intro']) .. '</p></header>')
  table.insert(doc.blocks, 1, pandoc.RawBlock('html', table.concat(parts)))
  local previous = current and stages[current-1]
  local following = current and stages[current+1]
  local nav = '<nav class="iframe-nav" aria-label="Adjacent stages">'
  nav = nav .. (previous and '<a href="' .. previous[1] .. '.html" rel="prev">← Previous: ' .. previous[2] .. '</a>' or '<span></span>')
  nav = nav .. (following and '<a class="nav-next" href="' .. following[1] .. '.html" rel="next">Next: ' .. following[2] .. ' →</a>' or '<a class="nav-next" href="index.html">Return to Start →</a>')
  table.insert(doc.blocks, pandoc.RawBlock('html', nav .. '</nav>'))
  return doc
end

-- Keep genuinely wide tables scrollable locally, with a keyboard-accessible region.
function Table(el)
  return {pandoc.RawBlock('html', '<p class="table-scroll-hint">On a narrow screen, scroll the table sideways to see all columns.</p><div class="table-scroll" role="region" aria-label="Course data table" tabindex="0">'), el, pandoc.RawBlock('html', '</div>')}
end

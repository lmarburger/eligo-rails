#= require jquery

$ = jQuery
$.fn.shiftClickable = ->
  checkboxes  = $ this
  anchorIndex = 1

  checkboxes
    .click (e) ->
      clicked = $ this
      newAnchorIndex = clicked.index()

      if e.shiftKey
        [ first, last ] = [ anchorIndex, newAnchorIndex ]
        [ first, last ] = [ last, first ] if first > last

        checkboxes
          .slice(first - 1, last - 1)
          .not(clicked)
          .prop('checked', !clicked.prop('checked'))

      anchorIndex = newAnchorIndex

# $ ->

#   # Using the click event here instead of change. This may not work consistently
#   # and across all browsers but I think it's the best way to catch if a checkbox
#   # has been shift+clicked.
#   anchor_drop    = $ drops_list.children('li')[0]
#   selected_drops = $()
#   drops_list.find('li :checkbox')
#
#     # Here's the logic gleaned from Finder for selecting and shift-selecting
#     # drops:
#     #
#     # [x] Clicked drop becomes the anchor
#     # [x] S-Click selects drops from the anchor to the clicked drop
#     # [x] S-Click deselects contiguously selected drops "below" the anchor
#     # [x] S-Click deselects contiguously selected drops "above" the clicked drop
#     #     if the clicked drop was selected
#     #
#     # Deselecting sets the anchor:
#     # [x] First selected drop below
#     # [x] First selected drop above
#     # [x] Nothing
#     .live 'click', (e) ->
#       checkbox = $(this)
#       clicked  = checkbox.closest 'li'
#       previously_selected = selected_drops.is clicked

#       if e.shiftKey
#         [ first, last ] = [ anchor_drop, clicked ]
#         [ first, last ] = [ last, first ] if first.index() > last.index()

#         if (first is clicked and previously_selected) or first is anchor_drop
#           first.prevUntil(':has(:checkbox:not(:checked))')
#             .find(':checkbox')
#               .prop('checked', false)
#               .change()

#         if (last is clicked and previously_selected) or last is anchor_drop
#           last.nextUntil(':has(:checkbox:not(:checked))')
#             .find(':checkbox')
#               .prop('checked', false)
#               .change()

#         drops_list
#           .children()
#           .slice(first.index(), last.index() + 1)
#           .find(':checkbox')
#             .prop('checked', true)
#             .change()

#       else
#         next_selected = clicked.nextAll(':has(:checkbox:checked)').first()
#         prev_selected = clicked.prevAll(':has(:checkbox:checked)').first()
#         anchor_drop = if checkbox.is ':checked'
#                         clicked
#                       else if next_selected.size()
#                         next_selected
#                       else if prev_selected.size()
#                         prev_selected
#                       else
#                         $ drops_list.children('li')[0]

#       selected_drops = drops_list.find('li:has(:checkbox:checked)')

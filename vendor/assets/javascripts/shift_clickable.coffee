#= require jquery

$ = jQuery
$.fn.shiftClickable = ->
  items = $(this).children('li')
  anchorIndex = 0

  items.find(':checkbox')
    .click (e) ->
      clicked = $(this).closest('li')
      newAnchorIndex = clicked.index()

      if e.shiftKey
        [ first, last ] = [ anchorIndex, newAnchorIndex ]
        [ first, last ] = [ last, first ] if first > last

        items
          .slice(first, last + 1)
          .not(clicked)
          .find(':checkbox')
          .prop('checked', !clicked.find(':checkbox').prop('checked'))

      anchorIndex = newAnchorIndex

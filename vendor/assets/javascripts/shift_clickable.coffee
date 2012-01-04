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

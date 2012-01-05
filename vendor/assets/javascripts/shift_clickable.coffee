#= require jquery

$ = jQuery
$.fn.shiftClickable = ->
  list  = $ this
  anchorIndex = 0

  shiftClick = (clicked, clickedIndex) ->
    [ first, last ] = [ anchorIndex, clickedIndex ]
    [ first, last ] = [ last, first ] if first > last

    list.children('li')
      .slice(first, last + 1)
      .not(clicked)
      .find(':checkbox')
      .prop('checked', clicked.find(':checkbox').prop('checked'))

  list.click (e) ->
    clicked = $(e.target).closest('li')
    clickedIndex = clicked.index()

    # It seems WebKit triggers `change` before `click`, but I'm not too
    # confident that all browsers must trigger events in exactly the same way.
    # Defer setting the value to be sure the checkbox has its new value.
    window.setTimeout(
      ->
        shiftClick clicked, clickedIndex if e.shiftKey
        anchorIndex = clickedIndex
      1)

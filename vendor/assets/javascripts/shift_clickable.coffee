#= require jquery

$ = jQuery
$.fn.shiftClickable = ->
  list   = $ this
  anchor = null
  anchorIndex = -> anchor?.index() ? 0

  shiftClick = (clicked) ->
    [ first, last ] = [ anchorIndex(), clicked.index() ]
    [ first, last ] = [ last, first ] if first > last

    checked = clicked.find(':checkbox').prop('checked')
    list.children('li')
      .slice(first, last + 1)
      .not(clicked)
      .find(':checkbox')
      .prop('checked', checked)

  list.click (e) ->
    clicked = $(e.target).closest('li')

    # It seems WebKit triggers `change` before `click`, but I'm not too
    # confident that all browsers must trigger events in exactly the same way.
    # Defer setting the value to be sure the checkbox has its new value.
    window.setTimeout(
      ->
        shiftClick clicked if e.shiftKey
        anchor = clicked
      1)

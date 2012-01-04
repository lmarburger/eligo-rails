#= require jquery
#= require jasmine-jquery
#= require sinon
#= require jasmine-sinon

describe 'shiftClickable()', ->
  checkboxHtml = '<input type="checkbox">'
  shiftClickEvent = jQuery.Event 'click', shiftKey: true
  body = null
  beforeEach -> body = $ 'body'

  it 'selects the first drops when shift clicking', ->
    first  = $(checkboxHtml).appendTo(body)
    last   = $(checkboxHtml).appendTo(body)

    $(':checkbox').shiftClickable()
    spyOnEvent first, 'change'
    last.trigger shiftClickEvent

    expect(first).toBeChecked()
    expect(last) .toBeChecked()

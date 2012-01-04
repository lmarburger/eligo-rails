#= require jquery
#= require jasmine-jquery
#= require sinon
#= require jasmine-sinon

describe 'shiftClickable()', ->

  shiftClickEvent = jQuery.Event 'click', shiftKey: true
  createCheckbox  = -> $('<input type="checkbox">').appendTo(body)

  body = first = second = third = null
  afterEach  -> body.find(':checkbox').remove()
  beforeEach ->
    body   = $ 'body'
    first  = createCheckbox()
    second = createCheckbox()
    third  = createCheckbox()

  it 'checks checkboxes between last and shift-clicked checkboxes', ->
    $(':checkbox').shiftClickable()
    first.trigger 'click'
    third.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()
    expect(third) .toBeChecked()

  it 'sets the default anchor above the first checkbox', ->
    $(':checkbox').shiftClickable()
    second.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()

  it 'does not check checkboxes above the anchor', ->
    $(':checkbox').shiftClickable()
    second.trigger 'click'
    third .trigger shiftClickEvent

    expect(second).toBeChecked()
    expect(third) .toBeChecked()
    expect(first) .not.toBeChecked()

  it 'does not check checkboxes below the anchor', ->
    $(':checkbox').shiftClickable()
    first .trigger 'click'
    second.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()
    expect(third) .not.toBeChecked()

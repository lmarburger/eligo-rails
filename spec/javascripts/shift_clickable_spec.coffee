#= require jquery
#= require jasmine-jquery
#= require sinon
#= require jasmine-sinon

describe 'shiftClickable()', ->

  list = first = second = third = null
  shiftClickEvent = jQuery.Event 'click', shiftKey: true
  createCheckbox  = ->
    $('<input type="checkbox">').appendTo(
      $('<li/>').appendTo(list))

  afterEach  -> list.remove()
  beforeEach ->
    list   = $ '<ul/>'
    first  = createCheckbox()
    second = createCheckbox()
    third  = createCheckbox()
    list.shiftClickable()

  it 'checks checkboxes between last and shift-clicked checkboxes', ->
    first.trigger 'click'
    third.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()
    expect(third) .toBeChecked()

  it 'checks checkboxes below the shift-clicked checkbox', ->
    $(':checkbox').shiftClickable()
    third.trigger 'click'
    first.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()
    expect(third) .toBeChecked()

  it 'sets a default anchor', ->
    $(':checkbox').shiftClickable()
    second.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()

  it 'does not check checkboxes above the selected group', ->
    $(':checkbox').shiftClickable()
    second.trigger 'click'
    third .trigger shiftClickEvent

    expect(second).toBeChecked()
    expect(third) .toBeChecked()
    expect(first) .not.toBeChecked()

  it 'does not check checkboxes below the selected group', ->
    $(':checkbox').shiftClickable()
    first .trigger 'click'
    second.trigger shiftClickEvent

    expect(first) .toBeChecked()
    expect(second).toBeChecked()
    expect(third) .not.toBeChecked()

  it 'unchecks checkboxes between last and shift-clicked checkboxes', ->
    $(':checkbox').shiftClickable()

    group = [ third, second, first ]
    checkbox.trigger 'click' for checkbox in group
    third.trigger shiftClickEvent

    expect(first) .not.toBeChecked()
    expect(second).not.toBeChecked()
    expect(third) .not.toBeChecked()

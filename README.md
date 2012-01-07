# Eligo

Add simple shift-click multi-select to a list of checkboxes.

[![Build Status](https://secure.travis-ci.org/lmarburger/eligo-rails.png)](http://travis-ci.org/lmarburger/eligo-rails)


## Installation

Eligo is packaged as a gem that can be dropped into a Rails 3.1 app thanks to
the [asset pipeline][]. Add the `eligo-rails` gem to your Gemfile:

```ruby
gem 'eligo-rails'
```

The JavaScript file `shift_clickable` is now available to require and use.

```html
<ul>
  <li>
    <input type="checkbox">
    Arthur Dent
  </li>
  <li>
    <input type="checkbox">
    Ford Prefect
  </li>
  <li>
    <input type="checkbox">
    Tricia McMillan
  </li>
  <li>
    <input type="checkbox">
    Zaphod Beeblebrox
  </li>
</ul>
```

```coffeescript
#= require shift_clickable

$ -> $('ul').shiftClickable()
```

Clicking on Arthur and then shift-clicking on Zaphod will also select both Ford
and Tricia.



[asset pipeline]: http://guides.rubyonrails.org/asset_pipeline.html

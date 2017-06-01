# BootstrapBuilders

The following examples are shown in HAML syntax but the project can of course be used with ERB and Slim as well.

## Install

Add to your Gemfile and bundle:
```ruby
gem "bootstrap_builders"
```

Then add to your `ApplicationHelper` module:
```ruby
module ApplicationHelper
  include BootstrapBuilders::ApplicationHelper
end
```

Then add to your `application.js`:
```javascript
//= require bootstrap_builders
```

Then add to your `application.css`:
```scss
//= require bootstrap_builders
```

## Usage

### Date picker input for SimpleForm

```haml
= f.input :activation_at, as: :bb_date_picker
= f.input :something_at, as: :bb_date_time_picker
```

You might encounter some trouble with specs. Use the helpers:
```ruby
config.include BootstrapBuilders::CapybaraSpecHelpers
```

And in the test:
```ruby
set_bb_date_input ".subscription_start_date", 2.days.from_now.to_date
```

### Panel

1. Panel in all its glory with elements and classes
2. Controls if `:right` argument is given
3. Table if `:table` argument is given

```haml
= bb_panel "Title of panel", controls: button_content do
  Content of panel
```

```haml
= bb_panel "Title of panel", controls: button_content do |panel|
  - panel.controls << bb_btn("#", "Another button", :mini)
  Content of panel
```

### Panel with a table

```haml
= bb_panel "Title of panel", table: true do
  %tbody
    %tr
      %td= "Test"
```

You can add custom classes like this:
```haml
= bb_panel "Title of panel", table: {bs_classes: [:striped]} do
  %tbody
    %tr
      %td Test
```

You can make the panel collapsed with the title functioning as the open toggle like this:
```haml
= bb_panel "Title", :collapsable, :collapsed do
  Content
```

### Table

1. Adds Bootstrap classes: "table", "table-hover", "table-striped"

```haml
= bb_table do
  %tbody
    %tr
      %td= "Test"
```

2. A table showing a models attributes:

```haml
= bb_table do
  %tbody
    = bb_attribute_rows @model, [:id, :created_at, :updated_at]
```

You can change the default classes like this:
```ruby
BootstrapBuilders.configuration.default_table_classes = [:striped, :hover]
```

The classes "bb-table" and "table" are always added.

### Buttons

1. Adds icons automatically
2. Adds labels automatically
3. Doesn't show button if CanCan doesn't allow it

```haml
= bb_new_btn url: [:admin, User]
= bb_edit_btn url: [:admin, user], :mini
= bb_destroy_btn url: [:admin, user], label: false
= bb_btn "/url", "My label", :block, :lg, :confirm, :disabled
```

### Responsive mixins

Use responsive mixins to only apply certain CSS rules on specific sizes, below or above.

```scss
.some-class {
  @include bb-when-sm-down() {
    width: 100px;
  }

  @include bb-when-md-up() {
    width: 200px;
  }
}

@include bb-when-xs() { ... }
@include bb-when-sm() { ... }
@include bb-when-sm-up() { ... }
@include bb-when-sm-down() { ... }
@include bb-when-md() { ... }
@include bb-when-md-up() { ... }
@include bb-when-md-down() { ... }
@include bb-when-lg() { ... }
```

### Responsive classes

```scss
.text-align-left-xs
.text-align-right-sm-up
.text-align-center-md-down
```

And so on...

### Tabs

```haml
= bb_tabs do |tabs|
  = tabs.tab "Title" do
    Content of tab
```

```haml
= bb_tabs :pills, :stacked do |tabs|
  = tabs.tab "Title", "id-of-content-container" do
    Content of tab
  = tabs.tab "Load on demand", ajax_url: some_path
```

Pre-select a tab by using the query parameter called "bb_selected_tab" like so: "?bb_selected_tab=id-of-content-container". This will also work with ajax tabs.

### Flash

```haml
= bb_flash
```

## Contributing to bootstrap_builders

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2016 kaspernj. See LICENSE.txt for
further details.

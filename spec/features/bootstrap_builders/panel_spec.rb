require "rails_helper"

describe BootstrapBuilders::Panel do
  it "generates a panel" do
    visit panel_with_content_bootstrap_builders_panels_path

    expect(page).to have_http_status(:success)
    expect(current_path).to eq panel_with_content_bootstrap_builders_panels_path

    table = find(".bb-panel")
    expect(table[:style]).to eq "width: 300;"

    title = find(".card-header .pull-left")
    expect(title.text).to eq "Test title"

    panel_body = find(".card-body")
    expect(panel_body.text).to eq "Test"

    expect(page).to have_selector ".controls-argument-button"
    expect(page).to have_selector ".controls-button"
  end

  it "generates a table" do
    visit panel_with_table_bootstrap_builders_panels_path

    title = find(".bb-panel .card-header")
    expect(title.text).to eq "Test title"

    panel_table = find(".table-responsive table.table")
    expect(panel_table.text).to eq "Hello world"

    # It should include the right classes
    classes = panel_table[:class].split(/\s+/)
    expect(classes).to include "table-striped"
  end

  it "allows custom classes for tables" do
    visit panel_with_table_and_custom_classes_bootstrap_builders_panels_path

    title = find(".bb-panel .card-header")
    expect(title.text).to eq "Test title"

    panel_table = find(".table-responsive table.table")
    table_classes = panel_table[:class].split(/\s+/)

    expect(panel_table.text).to eq "Hello world"
    expect(table_classes).to eq ["table-hover", "bb-panel-table", "table", "bb-table"]
  end

  it "skips the header bar when no controls or title" do
    visit panel_with_no_header_bootstrap_builders_panels_path

    expect(page).to have_http_status :success
    expect(page).to have_selector ".bb-panel"
    expect(page).to_not have_selector ".card-header"
  end

  it "generates collapse elements" do
    visit panel_with_collapse_bootstrap_builders_panels_path

    expect(page).to have_http_status :success
    expect(page).to have_selector ".panel-collapse.collapse.in"
  end

  it "generates collapse elements" do
    visit panel_with_collapse_bootstrap_builders_panels_path(collapsed: true)

    expect(page).to have_http_status :success
    expect(page).to have_selector ".panel-collapse.collapse:not(.in)"
  end
end

class BootstrapBuilders::Panel
  attr_accessor :context, :controls

  def self.with_parsed_args(*opts, &blk)
    title = opts.shift unless opts.first.is_a?(Hash)
    width = opts.shift unless opts.first.is_a?(Hash)

    if opts.length == 1 && opts.first.is_a?(Hash)
      args = opts.first
      title = args.fetch(:title) if args.key?(:title)
      width = args[:width] if args.key?(:width)
      right = args[:right] if args.key?(:right)
    else
      args = {}
    end

    BootstrapBuilders::Panel.new(args.merge(title: title, width: width, right: right, block: blk))
  end

  def initialize(args)
    @title = args.fetch(:title)
    @table = args[:table]
    @context = args[:context]
    @class = args[:class]
    @data = args[:data]

    @controls = args[:controls]
    @controls = [@controls] unless @controls.is_a?(Array)

    @css = {}
    @css[:width] = args.fetch(:width) if args[:width]

    @block = proc do
      args.fetch(:block).call(self)
    end
  end

  def html
    @panel = HtmlGen::Element.new(:div, inden: "  ", classes: container_classes, css: @css, data: @data)

    generate_body
    add_heading if heading?
    add_body
    add_heading_controls
    html = @panel.html

    if html.respond_to?(:html_safe)
      html.html_safe
    else
      html
    end
  end

private

  def add_heading
    @heading = @panel.add_ele(:div, classes: ["panel-heading", "clearfix"])

    if !@title || @title.to_s.strip.empty?
      @heading.add_ele(:div, classes: ["panel-title", "pull-left"], str_html: "&nbsp;") if controls?
    else
      @heading.add_ele(:div, classes: ["panel-title", "pull-left"], str: @title)
    end
  end

  def add_heading_controls
    @heading.add_ele(:div, classes: ["pull-right"], str_html: controls_content) if controls?
  end

  def controls?
    @controls && @controls.any?
  end

  def controls_content
    if @controls.is_a?(Array)
      @controls.join(" ")
    else
      @controls.to_s
    end
  end

  def heading?
    @title.present? || controls?
  end

  def table?
    @table.present?
  end

  def add_body
    @panel.add_html(@generated_body)
  end

  def container_classes
    classes = ["panel", "panel-default", "bb-panel"]

    if @class.is_a?(String)
      classes += @class.split(/\s+/)
    elsif @class.is_a?(Array)
      classes += @class
    end

    classes
  end

  def generate_body
    if table?
      generate_body_table
    else
      @generated_body = @context.content_tag(:div, nil, class: ["panel-body"], &@block)
    end
  end

  def generate_body_table
    bs_classes = BootstrapBuilders.configuration.default_table_classes - [:bordered]

    table_args = {
      class: "bb-panel-table",
      bs_classes: bs_classes,
      context: @context,
      blk: @block,
      responsive: true
    }

    table_args.merge!(@table) if @table.is_a?(Hash)
    @generated_body = BootstrapBuilders::Table.new(table_args).html
  end
end

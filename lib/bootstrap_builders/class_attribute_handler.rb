class BootstrapBuilders::ClassAttributeHandler
  attr_reader :classes

  def self.short(classes)
    BootstrapBuilders::ClassAttributeHandler.new(class: classes).classes
  end

  def initialize(args)
    @classes = convert_to_array(args.fetch(:class))
  end

  def add(class_argument)
    @classes += convert_to_array(class_argument)
  end

  def remove(class_argument)
    if class_argument.is_a?(Array)
      @classes -= class_argument
    else
      @classes.delete(class_argument)
    end
  end

  def include?(attr_class)
    @classes.include?(attr_class)
  end

private

  def convert_to_array(argument)
    return if argument.blank?
    return argument.split(/\s+/) if argument.is_a?(String)
    return argument if argument.is_a?(Array)
    return [] if args.fetch(:class).nil?
    raise "Unknown class-type: #{args.fetch(:class)}" unless @classes
  end
end

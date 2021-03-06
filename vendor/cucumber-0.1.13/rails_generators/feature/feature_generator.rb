# This generator bootstraps a Rails project for use with Cucumber
class FeatureGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory 'features/step_definitions'
      m.template  'feature.erb', "features/manage_#{plural_name}.feature"
      m.template  'steps.erb', "features/step_definitions/#{singular_name}_steps.rb"
    end
  end

  class NamedArg
    attr_reader :name

    def initialize(s)
      @name, @type = *s.split(':')
    end

    def value(n)
      if @type == 'boolean'
        (n % 2) == 0
      else
        "#{@name} #{n}"
      end
    end
  end

  def named_args
    args.map{|arg| NamedArg.new(arg)}
  end

  protected

  def banner
    "Usage: #{$0} feature ModelName [field:type, field:type]"
  end
end

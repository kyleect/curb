module Curb
  module RunnerInstanceAliases
    def call
      instance.call
    end

    def reset
      instance.reset
    end

    def add_feature(feature)
      instance.add_feature(feature)
    end

    def add_handler(handler)
      instance.add_handler(handler)
    end

    def add_handlers(handlers=[])
      instance.add_handlers(handlers)
    end
  end
end
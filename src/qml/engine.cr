module QML
  class Engine
    INSTANCE = self.new
    
    def initialize
      @pointer = LibQML.engine_new
    end

    def wrap(obj : ClientClass)
      LibQML.engine_new_wrapper(self, obj.class.metaclass, obj)
    end

    def to_unsafe
      @pointer
    end

    def finalize
      LibQML.engine_release(self)
    end
  end
end

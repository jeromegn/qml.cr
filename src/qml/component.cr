module QML

  class Component

    #
    def initialize(path : String? = nil, data : String? = nil)
      @pointer = LibQML.component_new(QML.engine)
      load path: path, data: data
    end

    def to_unsafe
      @pointer
    end

    def finalize
      LibQML.component_release(self)
    end

    #
    def load(path : String? = nil, data : String? = nil)
      p = path || ""
      d = data || ""

      case
      when path
        LibQML.component_load_path(self, p)
      when data
        LibQML.component_set_data(self, d, p)
      end

      string = error_string
      raise InvalidLoadException.new(string || "") if string
    end

    #
    def create
      JSValue.new LibQML.component_create(self)
    end

    #
    def error_string
      string = LibQML.component_get_error_string(self)
      if string.address == 0
        nil
      else
        String.new(LibQML.string_get_chars(string))
      end
    end

    class InvalidLoadException < Exception
      def initialize(message : String)
        super("Component raises error on load. From error string: \n" + message)
      end
    end
  end
end

module QML
  # Manages main parts of QML, such as root and event loop.
  # The rough-equivelent to (QApplication)[https://doc.qt.io/qt-5/qapplication.html] from the C++ lib
  class Application
    INSTANCE = self.new

    @root_component : Component?
    @root           : JSValue?

    delegate :engine, to: QML

    def initialize
      @pointer = LibQML.application_new(ARGV.size, ARGV.map(&.to_unsafe))
    end

    def load(path : String? = nil, data : String? = nil)
      @root_component = Component.new(path, data)
      @root = @root_component.not_nil!.create
    end

    def exec
      puts "Application exited with code: #{LibQML.application_exec(self)}"
    end

    def to_unsafe
      @pointer
    end

    def finalize
      LibQML.application_release(self)
    end
  end
end

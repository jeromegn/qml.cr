require "./qml/*"

module QML
  def self.run
    yield application
    application.exec
  end

  def self.application
    QML::Application::INSTANCE
  end

  def self.engine
    QML::Engine::INSTANCE
  end
end
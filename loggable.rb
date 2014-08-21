require 'active_support/concern'

module Loggable
  extend ActiveSupport::Concern

  included do
    attr_writer :logger
  end

  def logger
    @logger || default_logger
  end

  def log(message, level = :debug)
    puts_and_log(message, level)
  end

  def log_start_message
    puts_and_log(self.class::START_MESSAGE)
  end

  def log_end_message
    puts_and_log(self.class::END_MESSAGE)
  end

private

  def default_logger
    @default_logger ||= begin
      logger = Logger.new(self.class::LOG_FILE)
      logger.formatter = Logger::Formatter.new
      logger.level     = Logger::DEBUG
      logger
    end
  end

  def puts_and_log(msg, level)
    puts(msg)
    logger.send(level, msg)
  end
end

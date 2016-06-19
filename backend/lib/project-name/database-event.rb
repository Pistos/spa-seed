module ProjectName
  class DatabaseEvent
    attr_reader :table, :operation, :payload

    def initialize(table:, operation:, payload:)
      @table = table
      @operation = operation
      @payload = payload
    end
  end
end

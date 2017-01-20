module EventSource
  module EventStore
    module HTTP
      class Write
        include EventSource::Write

        dependency :put, Put

        def configure(session: nil)
          Put.configure self, session: session
        end

        def write(batch, stream_name, expected_version: nil)
          logger.trace { "Writing batch (Stream Name: #{stream_name}, Number of Events: #{batch.count}, Expected Version: #{expected_version.inspect})" }

          position = put.(batch, stream_name, expected_version: expected_version)

          last_position = position + (batch.count - 1)

          logger.debug { "Wrote batch (Stream Name: #{stream_name}, Number of Events: #{batch.count}, Expected Version: #{expected_version.inspect}, Last Position: #{last_position})" }

          last_position
        end
      end
    end
  end
end
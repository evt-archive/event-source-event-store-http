require_relative '../../automated_init'

context "Put" do
  context "No stream" do
    context "For a stream that exists" do
      stream_name = Controls::Write.(instances: 1)

      write_event = Controls::EventData::Write.example

      erroneous = proc {
        EventSource::EventStore::HTTP::Put.(
          write_event,
          stream_name,
          expected_version: EventSource::NoStream.name
        )
      }

      test "Is an error" do
        assert erroneous do
          raises_error? EventSource::ExpectedVersion::Error
        end
      end
    end
  end
end

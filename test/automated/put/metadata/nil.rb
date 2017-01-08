require_relative '../../automated_init'

context "Put, Metadata Is Nil" do
  stream_name = Controls::StreamName.example
  write_event = Controls::EventData::Write.example metadata: :none

  position = EventSource::EventStore::HTTP::Put.(write_event, stream_name)

  get_response = Controls::Read::Event.(stream_name, position: position)

  context "Read data" do
    event_store_data = JSON.parse(get_response.body)['content']

    test "Is empty string" do
      assert event_store_data['metadata'] == ''
    end
  end
end

module ReadFixture
  def read_fixture(fixture_path)
    let(:data) do
      JSON.parse(File.read(fixture_path)).deep_symbolize_keys
    end
  end
end

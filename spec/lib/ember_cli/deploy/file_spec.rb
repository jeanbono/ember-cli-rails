require "tmpdir"
require "ember_cli/deploy/file"

describe EmberCli::Deploy::File do
  describe "#index_html" do
    context "when the file is missing" do
      it "raises a BuildError" do
        deploy = EmberCli::Deploy::File.new(build_app)

        expect { deploy.index_html }.to raise_error(EmberCli::BuildError)
      end
    end

    it "returns the contents of the app's `index_file`" do
      app = build_app
      create_index(app.dist_path, "<html></html>")
      deploy = EmberCli::Deploy::File.new(app)

      index_html = deploy.index_html

      expect(index_html).to eq("<html></html>")
    end
  end

  def create_index(directory, contents)
    directory.join("index.html").write(contents)
  end

  def build_app
    tmpdir = Pathname.new(Dir.mktmpdir)

    double(dist_path: tmpdir, check_for_errors!: false)
  end
end

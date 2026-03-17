# This formula should be copied to the homebrew-todo-sync tap repo
# Install: brew tap jaimelucero/todo-sync && brew install todo-sync

class TodoSync < Formula
  desc "Bidirectional sync between TODO.md and GitHub Issues"
  homepage "https://github.com/jaimelucero/todo-sync"
  url "https://github.com/jaimelucero/todo-sync/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "cc8934b5ae9071fa11b99564eaca51fc75b06b00388456d974dc002774e52a85"
  version "1.0.3"
  license "MIT"

  depends_on "python3"

  def install
    # Install Python scripts to libexec (similar to Homebrew's Python package pattern)
    libexec.install "scripts/sync.py"

    # Install templates to the prefix root so sync.py can find them at ../templates
    prefix.install "templates"

    # Install the bin/ wrapper
    bin.install "bin/todo-sync"

    # The bin/todo-sync script will find sync.py at ../libexec/sync.py
    # The sync.py script will find templates at ../templates
  end

  test do
    system "#{bin}/todo-sync", "--version"
    assert_match "todo-sync", shell_output("#{bin}/todo-sync --help")
  end
end

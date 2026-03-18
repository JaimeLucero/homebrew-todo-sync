# This formula should be copied to the homebrew-todo-sync tap repo
# Install: brew tap jaimelucero/todo-sync && brew install todo-sync

class TodoSync < Formula
  desc "Bidirectional sync between TODO.md and GitHub Issues"
  homepage "https://github.com/jaimelucero/todo-sync"
  url "https://github.com/jaimelucero/todo-sync/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "c61154c8d95c9b74def5ccf8cb972f6578c5c4ad18d91587c0f99fefb6fa0d71"
  version "1.1.0"
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

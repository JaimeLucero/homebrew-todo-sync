# This formula should be copied to the homebrew-todo-sync tap repo
# Install: brew tap jaimelucero/todo-sync && brew install todo-sync

class TodoSync < Formula
  desc "Bidirectional sync between TODO.md and GitHub Issues"
  homepage "https://github.com/jaimelucero/todo-sync"
  url "https://github.com/jaimelucero/todo-sync/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "39f16d4161db75684b64371d257f06885f9b45aafc1698b6fa11996268943179"
  version "1.1.1"
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

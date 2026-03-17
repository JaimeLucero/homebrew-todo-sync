# This formula should be copied to the homebrew-todo-sync tap repo
# Install: brew tap jaimelucero/todo-sync && brew install todo-sync

class TodoSync < Formula
  desc "Bidirectional sync between TODO.md and GitHub Issues"
  homepage "https://github.com/jaimelucero/todo-sync"
  url "https://github.com/jaimelucero/todo-sync/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "116f7e14df319b009ae16fabf37f49479e38449a06299a53793ec19dca683f2b"
  version "1.0.1"
  license "MIT"

  depends_on "python3"

  def install
    # Install Python scripts to libexec (similar to Homebrew's Python package pattern)
    libexec.install "scripts/sync.py"
    libexec.install "templates"

    # Install the bin/ wrapper
    bin.install "bin/todo-sync"

    # The bin/todo-sync script will find sync.py at ../libexec/sync.py
  end

  test do
    system "#{bin}/todo-sync", "--version"
    assert_match "todo-sync", shell_output("#{bin}/todo-sync --help")
  end
end

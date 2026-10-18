class Zch < Formula
  desc "TUI dashboard for competitive programming: receive problems, run tests, and submit to Codeforces"
  homepage "https://github.com/prsweet/zch"
  version "2.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/prsweet/zch/releases/download/v2.0.1/zch-aarch64-apple-darwin.tar.xz"
      sha256 "e6f0f38d5607e5356e19f55236bd7ee5a44dc13b6cc846efe0e7d108d58e41c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/prsweet/zch/releases/download/v2.0.1/zch-x86_64-apple-darwin.tar.xz"
      sha256 "926a6917c8d36a9da094b77cc76bfe9e46521a415dbbcf7afb4039db7f0b2056"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "zch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zch"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

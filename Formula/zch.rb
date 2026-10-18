class Zch < Formula
  desc "TUI dashboard for competitive programming: receive problems, run test cases, and submit to Codeforces / AtCoder"
  homepage "https://github.com/prsweet/zch"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/prsweet/zch/releases/download/v2.0.0/zch-aarch64-apple-darwin.tar.xz"
      sha256 "e2dc401edcda62b8f73a60b264bac0282925f051346639634dac1b7445c32fda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/prsweet/zch/releases/download/v2.0.0/zch-x86_64-apple-darwin.tar.xz"
      sha256 "531e884d4d55161fd9a244a82f17ab70d89a2f9d175be71f56502c2cbbd0509e"
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

class Zch < Formula
  desc "TUI dashboard for competitive programming: receive problems, run tests, and submit to Codeforces"
  homepage "https://github.com/prsweet/zch"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/prsweet/zch/releases/download/v3.0.0/zch-aarch64-apple-darwin.tar.xz"
      sha256 "e280a4748f760a4c409191cb21c253896c846ba021785a0cf76d91733ee1229b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/prsweet/zch/releases/download/v3.0.0/zch-x86_64-apple-darwin.tar.xz"
      sha256 "77f76363190cf2bb8814deb570ec1d991f27aae745fcec6d62cb599357893e09"
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

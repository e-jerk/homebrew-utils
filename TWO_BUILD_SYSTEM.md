# Two-Build System

Each utility (find, gawk, grep, sed) has two separate builds:

## 1. Standard Build (with GNU fallback)
- **License**: GPL-3.0-or-later
- **Includes**: e-jerk GPU code + GNU fallback via `--gnu` flag
- **Homebrew**: `find-gnu`, `gawk-gnu`, `grep-gnu`, `sed-gnu`
- **Docker**: `ghcr.io/e-jerk/find-gnu:latest`, `ghcr.io/e-jerk/gawk-gnu:latest`, etc.
- **Dockerfile target**: `runtime-gnu`
- **Build**: `zig build -Doptimize=ReleaseFast -Dgnu=true`

## 2. Pure Build (e-jerk only, default)
- **License**: Unlicense (public domain) / MIT
- **Includes**: Only e-jerk GPU/CPU code, no GNU code
- **Homebrew**: `find`, `gawk`, `grep`, `sed`
- **Docker**: `ghcr.io/e-jerk/find:latest`, `ghcr.io/e-jerk/gawk:latest`, etc.
- **Dockerfile target**: `runtime-pure`
- **Build**: `zig build -Doptimize=ReleaseFast`

## Homebrew Installation

### Standard (with GNU fallback)
```bash
# Install all utilities
brew install e-jerk/utils/gpu-utils-gnu

# Or individually
brew install e-jerk/utils/find-gnu
brew install e-jerk/utils/gawk-gnu
brew install e-jerk/utils/grep-gnu
brew install e-jerk/utils/sed-gnu
```

### Pure (e-jerk only, default)
```bash
# Install all utilities
brew install e-jerk/utils/gpu-utils

# Or individually
brew install e-jerk/utils/find
brew install e-jerk/utils/gawk
brew install e-jerk/utils/grep
brew install e-jerk/utils/sed
```

## Docker Images

### Standard
```bash
docker pull ghcr.io/e-jerk/find-gnu:latest
docker pull ghcr.io/e-jerk/gawk-gnu:latest
docker pull ghcr.io/e-jerk/grep-gnu:latest
docker pull ghcr.io/e-jerk/sed-gnu:latest
```

### Pure
```bash
docker pull ghcr.io/e-jerk/find:latest
docker pull ghcr.io/e-jerk/gawk:latest
docker pull ghcr.io/e-jerk/grep:latest
docker pull ghcr.io/e-jerk/sed:latest
```

## Build System Changes Required

Each utility repository needs:

1. **build.zig modification**: Add `-Dgnu` option to conditionally include GNU code
2. **CI/CD updates**: Build both variants using Docker targets
3. **Release artifacts**: Generate separate tarballs for each variant

### Example build.zig addition:
```zig
const gnu = b.option(bool, "gnu", "Build with GNU fallback code") orelse false;

// Conditionally add GNU sources only if gnu build
if (gnu) {
    addGnuGrepSources(exe, b, gnu_grep, c_flags);
    exe.root_module.addImport("cpu_gnu", cpu_gnu_module);
}
```

### Docker build commands:
```bash
# Pure build (default)
docker build --target runtime-pure -t ghcr.io/e-jerk/grep:latest .

# GNU build
docker build --target runtime-gnu --build-arg BUILD_VARIANT=gnu -t ghcr.io/e-jerk/grep-gnu:latest .
```

## Formula Hash Updates

After building release artifacts, update the SHA256 hashes in each formula:
- `Formula/find.rb` - pure build hashes
- `Formula/find-gnu.rb` - gnu build hashes
- (repeat for gawk, grep, sed)

Use `shasum -a 256 <tarball>` to generate hashes.

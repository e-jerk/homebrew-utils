# GPU-Accelerated Unix Utilities

Drop-in replacements for `find`, `gawk`, `grep`, and `sed` with GPU acceleration via Metal (macOS) and Vulkan (Linux/cross-platform).

## Installation

### Homebrew

```bash
# Add the tap
brew tap e-jerk/utils

# Install all utilities
brew install e-jerk/utils/gpu-utils

# Or install individually
brew install e-jerk/utils/find
brew install e-jerk/utils/gawk
brew install e-jerk/utils/grep
brew install e-jerk/utils/sed
```

### Docker

Images are available on GitHub Container Registry:

```bash
# Pull images
docker pull ghcr.io/e-jerk/find:latest
docker pull ghcr.io/e-jerk/gawk:latest
docker pull ghcr.io/e-jerk/grep:latest
docker pull ghcr.io/e-jerk/sed:latest
```

## Quick Start

All utilities work as drop-in replacements with automatic backend selection:

```bash
find . -name "*.txt"
gawk '/pattern/' file.txt
grep "error" server.log
sed 's/foo/bar/g' config.txt
```

Pipe data through stdin:

```bash
cat largefile.txt | grep "pattern"
cat data.txt | gawk '{print $2}'
echo "/home /var" | find - -name "*.conf"
echo "hello world" | sed 's/world/gpu/'
```

Force GPU acceleration with `--gpu` or use `--cpu` for comparison:

```bash
grep --gpu "pattern" largefile.log
gawk --gpu '/pattern/' largefile.txt
sed --cpu 's/old/new/g' file.txt
```

---

## gawk

GPU-accelerated AWK text processor with parallel pattern matching and field extraction.

### Usage

```
Usage: gawk [OPTION]... 'PROGRAM' [FILE]...
Process text using AWK patterns and actions.
If no FILE is given, read standard input.
Example: gawk '/error/ {print $1, $3}' server.log

Pattern matching:
  /PATTERN/             match lines containing PATTERN
  !/PATTERN/            match lines NOT containing PATTERN
  -i, --ignore-case     ignore case distinctions in patterns
  -v, --invert-match    select non-matching lines

Field processing:
  -F, --field-separator=SEP  use SEP as field separator (default: whitespace)
  {print $N}            print field N (1-indexed)
  {print $1, $3}        print multiple fields

Built-in functions:
  length($N)            return length of field N
  substr($N, s, l)      substring starting at s with length l
  substr($N, s)         substring from s to end
  index($N, "str")      position of str in field (1-indexed)
  toupper($N)           convert to uppercase
  tolower($N)           convert to lowercase

Special variables:
  NR                    current line number
  NF                    number of fields in current line

Output control:
  -V, --verbose         print backend and timing information

GPU Backend selection:
  --auto                auto-select optimal backend (default)
  --gpu                 force GPU (Metal on macOS, Vulkan on Linux)
  --cpu                 force CPU backend
  --gnu                 force GNU gawk backend
  --metal               force Metal backend (macOS only)
  --vulkan              force Vulkan backend

Miscellaneous:
  -h, --help            display this help text and exit
      --version         display version information and exit

When FILE is '-', read standard input. With no FILE, read standard input.
```

### Examples

```bash
# Print lines matching pattern
gawk '/error/' server.log

# Print specific field
gawk '{print $2}' data.txt

# Pattern with field extraction
gawk '/error/ {print $1, $3}' server.log

# Custom field separator
gawk -F: '{print $1}' /etc/passwd

# Case-insensitive matching
gawk -i '/ERROR/' log.txt

# Built-in functions
gawk '{print length($1)}' file.txt
gawk '{print substr($1, 1, 3)}' file.txt
gawk '{print toupper($1)}' file.txt

# Special variables
gawk '{print NR, $0}' file.txt    # Line numbers
gawk '{print NF}' file.txt        # Field count

# Force GPU acceleration
gawk --gpu '/pattern/' largefile.txt

# Read from stdin
cat file.txt | gawk '{print $2}'
```

### Docker

```bash
# Process a file
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/gawk '/pattern/' /data/file.txt

# Extract fields with custom separator
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/gawk -F: '{print $1}' /data/passwd

# Read from stdin
cat data.txt | docker run --rm -i \
    ghcr.io/e-jerk/gawk '{print $2}'

# GPU-accelerated processing (Linux)
docker run --rm -v "$(pwd):/data" --device /dev/dri \
    ghcr.io/e-jerk/gawk --gpu '/error/' /data/server.log
```

### Performance

| Operation | Speedup |
|-----------|---------|
| Regex patterns (`/[0-9]+/`) | ~1,500x |
| Pattern matching (`/error/`) | ~15x |
| Field extraction (`{print $2}`) | ~8x |
| Case-insensitive (`-i`) | ~6x |
| Built-in functions | ~8x |

---

## grep

GPU-accelerated text search with parallel pattern matching.

### Usage

```
Usage: grep [OPTION]... PATTERN [FILE]...
Search for PATTERN in each FILE.
If no FILE is given, read standard input.
Example: grep -i 'hello world' menu.h main.c

Pattern selection and interpretation:
  -F, --fixed-strings       PATTERN is a literal string
  -i, --ignore-case         ignore case distinctions in patterns and data
  -w, --word-regexp         match only whole words
  -v, --invert-match        select non-matching lines

Output control:
  -V, --verbose             print backend and timing information

GPU Backend selection:
  --auto                    auto-select optimal backend (default)
  --gpu                     force GPU (Metal on macOS, Vulkan on Linux)
  --cpu                     force CPU backend
  --metal                   force Metal backend (macOS only)
  --vulkan                  force Vulkan backend

GPU tuning:
  --prefer-gpu              bias auto-selection toward GPU
  --prefer-cpu              bias auto-selection toward CPU
  --gpu-bias=NUM            fine-tune GPU preference (-10 to +10)
  --min-gpu-size=SIZE       minimum input size for GPU (e.g., 128K)
  --max-gpu-size=SIZE       maximum input size for GPU (e.g., 16M)

Miscellaneous:
  -h, --help                display this help text and exit
      --version             display version information and exit

When FILE is '-', read standard input. With no FILE, read standard input.
Exit status is 0 if any line is selected, 1 otherwise;
if any error occurs, the exit status is 2.
```

### Examples

```bash
# Search for pattern in file
grep 'error' /var/log/syslog

# Case-insensitive search
grep -i 'warning' *.log

# Read from stdin
cat file.txt | grep 'pattern'

# Force GPU acceleration
grep --gpu 'needle' haystack.txt

# Word boundary matching
grep -w 'the' document.txt
```

### Docker

```bash
# Search a file
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/grep "pattern" /data/file.txt

# Case-insensitive search
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/grep -i "error" /data/logs/*.log

# Read from stdin
cat largefile.txt | docker run --rm -i \
    ghcr.io/e-jerk/grep "pattern"

# GPU-accelerated search (Linux)
docker run --rm -v "$(pwd):/data" --device /dev/dri \
    ghcr.io/e-jerk/grep --gpu "needle" /data/haystack.txt
```

### Performance

| Workload | Speedup |
|----------|---------|
| Single char patterns | ~10x |
| Case-insensitive (`-i`) | ~8x |
| Word boundary (`-w`) | ~7x |
| Short patterns (2-4 chars) | ~5x |
| Long patterns (8+ chars) | ~2x |

---

## sed

GPU-accelerated stream editor with parallel substitution.

### Usage

```
Usage: sed [OPTION]... {SCRIPT-ONLY-IF-NO-OTHER-SCRIPT} [INPUT-FILE]...

Stream editor for filtering and transforming text.
If no INPUT-FILE is given, or if INPUT-FILE is -, read standard input.

Options:
  -n, --quiet, --silent    suppress automatic printing of pattern space
  -e SCRIPT, --expression=SCRIPT
                           add the script to the commands to be executed
  -i, --in-place           edit files in place
  -V, --verbose            print backend and timing information
  -h, --help               display this help and exit
      --version            output version information and exit

GPU Backend selection:
  --auto                   auto-select optimal backend (default)
  --gpu                    force GPU (Metal on macOS, Vulkan on Linux)
  --cpu                    force CPU backend
  --metal                  force Metal backend (macOS only)
  --vulkan                 force Vulkan backend

Commands:
  s/REGEXP/REPLACEMENT/FLAGS
      Substitute REGEXP with REPLACEMENT.
      FLAGS: g (global), i (ignore case), 1 (first only)

  y/SOURCE/DEST/
      Transliterate characters in SOURCE to DEST.

  /REGEXP/d
      Delete lines matching REGEXP.

  /REGEXP/p
      Print lines matching REGEXP.
```

### Examples

```bash
# Replace all occurrences
sed 's/foo/bar/g' input.txt

# Edit file in place
sed -i 's/old/new/g' file.txt

# Read from stdin
cat file.txt | sed 's/a/b/g'

# Pipe through sed
echo "hello" | sed 's/hello/hi/'

# Force GPU acceleration
sed --gpu 's/x/y/g' large.txt

# Delete lines matching pattern
sed '/^#/d' config.conf

# Transliterate characters
sed 'y/abc/xyz/' file.txt
```

### Docker

```bash
# Substitute in a file
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/sed 's/foo/bar/g' /data/file.txt

# Delete comment lines
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/sed '/^#/d' /data/config.conf

# Read from stdin
cat input.txt | docker run --rm -i \
    ghcr.io/e-jerk/sed 's/old/new/g'

# Pipe from echo
echo "hello world" | docker run --rm -i \
    ghcr.io/e-jerk/sed 's/world/gpu/'

# GPU-accelerated substitution (Linux)
cat hugefile.log | docker run --rm -i --device /dev/dri \
    ghcr.io/e-jerk/sed --gpu 's/error/ERROR/g'
```

### Performance

| File Size | Speedup |
|-----------|---------|
| 1MB  | ~2x |
| 10MB | ~5x |
| 50MB | ~7x |

---

## find

GPU-accelerated file finder with parallel pattern matching.

### Usage

```
Usage: find [-H] [-L] [-P] [path...] [expression]

Search for files in a directory hierarchy.
Default path is the current directory. Use - to read paths from stdin.

Tests:
  -name PATTERN     Base of file name matches shell PATTERN
  -iname PATTERN    Like -name but case-insensitive
  -path PATTERN     File path matches shell PATTERN
  -ipath PATTERN    Like -path but case-insensitive
  -type TYPE        File is of type TYPE:
                      f  regular file
                      d  directory
                      l  symbolic link
                      b  block device
                      c  character device
                      p  named pipe (FIFO)
                      s  socket

Options:
  -maxdepth LEVELS  Descend at most LEVELS of directories
  -mindepth LEVELS  Do not apply tests or actions at levels less than LEVELS
  -print0           Print paths followed by NUL instead of newline
  -count            Print count of matches (custom extension)

GPU Backend selection:
  --auto            auto-select optimal backend (default)
  --gpu             force GPU (Metal on macOS, Vulkan on Linux)
  --cpu             force CPU backend
  --metal           force Metal backend (macOS only)
  --vulkan          force Vulkan backend

Miscellaneous:
  -v, --verbose     print backend and timing information
  -h, --help        display this help and exit
      --version     output version information and exit

Pattern wildcards:
  *      matches any string
  ?      matches any single character
  [abc]  matches any character in the set
  [a-z]  matches any character in the range
  [!abc] matches any character NOT in the set
```

### Examples

```bash
# Find all .txt files
find . -name '*.txt'

# Case-insensitive search
find . -iname '*.jpg'

# Find log files in /var/log
find /var/log -type f -name '*.log'

# Combine with xargs
find . -name '*.c' -print0 | xargs -0 grep 'TODO'

# Read paths from stdin
echo '/home /var' | find - -name '*.conf'

# Force GPU backend
find --gpu . -name '*.rs'

# Limit depth
find . -maxdepth 2 -name '*.py'
```

### Docker

```bash
# Search current directory
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/find /data -name "*.txt"

# Find large files
docker run --rm -v "$(pwd):/data" \
    ghcr.io/e-jerk/find /data -type f -size +10M

# Read paths from stdin
echo "/data/logs /data/config" | docker run --rm -i -v "$(pwd):/data" \
    ghcr.io/e-jerk/find - -name "*.log"

# GPU-accelerated search (Linux)
docker run --rm -v "$(pwd):/data" --device /dev/dri \
    ghcr.io/e-jerk/find --gpu /data -name "*.log"
```

### Performance

| Files | Speedup |
|-------|---------|
| 10K   | ~4x     |
| 100K  | ~7x     |
| 1M    | ~10x    |

---

## Backend Selection

All utilities support the same backend flags:

| Flag | Description |
|------|-------------|
| `--auto` | Automatically select optimal backend (default) |
| `--gpu` | Use GPU (Metal on macOS, Vulkan elsewhere) |
| `--cpu` | Force CPU backend |
| `--metal` | Force Metal backend (macOS only) |
| `--vulkan` | Force Vulkan backend |
| `-V, --verbose` | Show timing and backend information |

The auto-selection algorithm considers:
- Input size (larger inputs benefit more from GPU)
- Pattern complexity
- Available hardware
- Transfer overhead vs. computation time

## Requirements

### macOS
- Apple Silicon or Intel Mac with Metal support (built-in)
- MoltenVK recommended for Vulkan backend (`brew install molten-vk`)

### Linux
- Vulkan runtime: `apt install libvulkan1 mesa-vulkan-drivers`
- GPU with Vulkan support (AMD, Intel, NVIDIA, or software rendering)

### Docker
- Vulkan runtime included in images
- For GPU passthrough: `--device /dev/dri` (Linux)
- For stdin: use `-i` flag (`docker run --rm -i`)

## Upgrading

```bash
# Upgrade all utilities
brew upgrade e-jerk/utils/gpu-utils

# Upgrade individually
brew upgrade e-jerk/utils/find
brew upgrade e-jerk/utils/grep
brew upgrade e-jerk/utils/sed
```

## Building from Source

Each utility can be built from source using Zig 0.15.2+:

```bash
git clone https://github.com/e-jerk/grep
cd grep
zig build -Doptimize=ReleaseFast
```

See individual repositories for detailed build and test instructions:
- [find](https://github.com/e-jerk/find)
- [gawk](https://github.com/e-jerk/gawk)
- [grep](https://github.com/e-jerk/grep)
- [sed](https://github.com/e-jerk/sed)

## License

Source code: [Unlicense](LICENSE) (public domain)
Binaries: GPL-3.0-or-later

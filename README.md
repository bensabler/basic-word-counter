# basic-word-counter

A tiny Go CLI inspired by the classic Unix `wc`. It reads from **stdin** and prints a single integer representing the count of **words** (default), **lines**, or **bytes**.

This project is intentionally minimal: one main program, a small `count()` helper, and unit tests.

---

## Features

- **Default:** count words
- `-l`: count lines
- `-b`: count bytes
- Reads input from **standard input (stdin)**, so it composes nicely with pipes and redirects

---

## Usage

### Count words (default)
```bash
echo "one two three" | ./bin/wc
> 3
```

### Count lines
```bash
printf "a\nb\nc\n" | ./bin/wc -l
> 3
```

### Count bytes
```bash
echo -n "hello" | ./bin/wc -b
> 5
```

## Build

### Build for your current OS/arch
```bash
make build
```

### Cross-compile for Windows, Linux, and macOS (amd64/arm64)
```bash
make build-all
```

### Run tests (verbose)
```bash
make test
```

### Clean build artifacts
```bash
make clean
```



## Project Layout
```
.
├── cmd
│   └── wc
│       └── main.go
│       └── main_test.go
├── Makefile
└── go.mod
└── README.md
```

## How it works
### The core logic lives in:
```
func count(r io.Reader, countLines, countBytes bool) int
```
It uses a `bufio.Scanner`:
- **default split**: ScanWords (word counting)
- `-l`: uses the scanner default (line splitting)
- `-b`: uses ScanBytes (byte counting)

## Testing
Unit tests cover:
- word counting
- line counting
- byte counting

## License
MIT
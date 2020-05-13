ifndef GCC
	GCC := x86_64-linux-musl-gcc
endif

.PHONY: init update-version clean build test cover open-coverage-html scan

init:
	rm -rf .git/hooks
	ln -s ../scripts/git-hooks .git/hooks
	chmod -R +x ./scripts/*

update-version:
	sed 's/version = "0.0.0"/version = "$(VERSION)"/g' Cargo.toml > Cargo.toml.tmp
	mv Cargo.toml.tmp Cargo.toml

clean:
	cargo clean

build:
	CC_x86_64_unknown_linux_musl=$(GCC) cargo build --release --target x86_64-unknown-linux-musl
	zip -j target/bootstrap.zip ./target/x86_64-unknown-linux-musl/release/bootstrap

test:
	cargo test -- --nocapture

cover-flags := CARGO_INCREMENTAL=0 RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Cinline-threshold=0 -Clink-dead-code -Coverflow-checks=off"
cover:
	$(cover-flags) cargo +nightly build
	$(cover-flags) cargo +nightly test
	grcov ./target/debug/ -s . -t lcov --llvm --ignore-not-existing -o ./target/debug/coverage
	genhtml -o ./target/debug/coverage-html --show-details --highlight ./target/debug/coverage

open-coverage-html:
	open ./target/debug/coverage-html/index.html

scan:
	cargo clippy --all-targets --all-features -- -D warnings

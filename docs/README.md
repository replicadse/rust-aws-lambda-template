# rust-aws-lambda-template

[![pipeline](https://github.com/replicadse/rust-aws-lambda-template/workflows/pipeline/badge.svg)](https://github.com/replicadse/rust-aws-lambda-template/actions?query=workflow%3Apipeline)
<!--
    [![crates.io](https://img.shields.io/crates/v/rust-aws-lambda-template.svg)](https://crates.io/crates/rust-aws-lambda-template)
    [![docs.rs](https://img.shields.io/badge/docs.rs-latest-blue)](https://docs.rs/rust-aws-lambda-template/latest/rust-aws-lambda-template/)
-->

## Prerequisites

* Ensure that you have the cross compilation ability for `amazon-linux` (`x86_64-unknown-linux-musl`). For MacOS, install `musl-cross` via `homebrew`.
* Make sure that you have the (`rustup`) target `x86_64-unknown-linux-musl` installed (`rustup target add x86_64-unknown-linux-musl`).

## Getting started (minimal example)

1) `make init` (initializes repo with pre-commit hooks etc.)
2) `make build` (build the library for use in aws-lambda)
3) Create a new lambda function
    1) Give it a funny name like `gambling-goose` or `kenny-mccormick`
    2) Choose `Provide your own bootstrap` from the `Runtime` dropdown menu.
    3) Press create
4) Configure lambda fucntion
    1) Go to `Function code`
    2) Choose `Upload a .zip file` from the `Code entry type` dropdown menu and upload `./target/bootstrap.zip`
    3) Choose `Custom runtime` from the `Runtime` dropdown menu
    4) Specify `Provided` as event handler in the `Handler` menu
5) Configure test events & invoke function
    1) Go to the top bar and select `Configure test events` from the dropdown menu
    2) Add new event that contains following JSON data:
        ```
            {
                "the_name": "Raymond"
            }
        ```
    3) Invoke the newly created test event
    4) Profit
6) Congratulations, you have created your first AWS-Lambda function built with RUST.

<!-- cargo-sync-readme start -->


<!-- cargo-sync-readme end -->

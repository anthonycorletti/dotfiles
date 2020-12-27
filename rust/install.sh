if test ! $(which rustc)
then
    echo "installing rust for you"
    curl -s https://static.rust-lang.org/rustup.sh | sh -s -- -y --channel=nightly
fi
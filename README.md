# Custom Formulae
Collection of custom and deprecated formulae.

## Installation

```bash
brew tap laggardkernel/tap
brew install laggardkernel/tap/<formula>
# not recommended, brew tap-pin laggardkernel/tap
```

## Formulae
~~curl~~
- `with-rtmpdump,` build with RTMP support
- `with-libssh2,` build with scp and sftp support
- `with-c-ares,` build with C-Ares async DNS support
- `with-gssapi,` build with GSSAPI/Kerberos authentication support.
- `with-libmetalink,` build with libmetalink support.
- `with-nghttp2,` build with HTTP/2 support (requires OpenSSL)

curl-openssl
- `with-openssl@1.1`, build with openssl 1.1. (tls 1.3 enabled)

httpd
- `with-openssl@1.1`, enable tls 1.3 in Apache

libass
- `--with-fontconfig` option

libcaca
- `--with-imlib2` option (X11 is needed)

nginx
- `with-openssl@1.1`, enable tls 1.3 support through openssl 1.1

openssh
- `--with-libressl`

[sans](https://github.com/puxxustc/sans)

unbound
- `--with-python@2`
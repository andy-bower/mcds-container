# OCI container definition for mcds CardDav client

The [mcds](https://github.com/t-brown/mcds) CardDav client does a fine job of looking up NextCloud directory entries on behalf of the mutt e-mail client but was marginally awkward to build on account of `autoconf`'s ... unfriendliness. In the end it built happily on Debian 10, 11 and 12 but I didn't get it working on Debian unstable so here's a Debian 12-based container!

Having pulled the docker image I created a directory with a suitable `.muttrc` and `.netrc` and mapped it in on the command invoking the tool in the `mutt` configuration:

```
set query_command="docker run -v ~/opt/mcds:/root -t quay.io/ajb85/mcds:deb12-i386 mcds %s"
```

I'm not really sure how useful the GPG support is in this tool so I am inclined to spin a build without it to keep the size down and probably speed up invocation on this low end host.

[![Docker Repository on Quay](https://quay.io/repository/ajb85/mcds/status "Docker Repository on Quay")](https://quay.io/repository/ajb85/mcds)

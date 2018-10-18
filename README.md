# Client Data for TMW2
[![pipeline status](https://gitlab.com/TMW2/clientdata/badges/master/pipeline.svg)](https://gitlab.com/TMW2/clientdata/commits/master)

Remember to link music repo music folder here.
Example command:

```sh
ln -s music/music client-data/
```

Useful commands:

```sh
make contrib
```

Make contributors list, both for wiki and client-data.
You'll later have to git add and git pull the wiki repository (wiki/ folder)

```sh
make pipeline
```

Runs an even shorter testxml, and then does an ICC check. Fix all errors and warnings
before pushing any work or your changes **may be reverted**.

----
## Licenses

Official Server License is GPL v3. Most data here is on compatibility, original
license as CC BY-SA, and therefore, requires special care before re-using.

You can find attribution and data on `LICENSE` and `SAULC.txt` files.

If something is not listed there, assume GPL v2+. (No attribution but Copyrights
fields required). If it is listed, but it's not filled, it means author is unknown
at the moment, but it can be used as GPL v2+.

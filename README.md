# Client Data for TMW2

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

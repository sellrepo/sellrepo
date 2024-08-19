# SellRepo

Your personal storefront for selling access to GitHub repositories.

## Usage

To get started with SellRepo, we recommend creating a new repository and cloning the application into it. This will allow you to merge updates with git in the future.

```bash
git clone https://github.com/excid3/sellrepo
cd sellrepo
git remote rename origin upstream

# Add your repository as origin
git remote

# Push to your repository
git push -u origin main
```

Now you have a full copy of SellRepo in your own repository as the `origin` remote and the `sellrepo` remote for pulling updates.

To merge updates, you can fetch and merge from the sellrepo upstream.

```bash
git fetch sellrepo
git merge sellrepo/main
```

> [!NOTE]
> If you'd like to contribute a bug fix or improvement, you can fork the repository and send a Pull Request.

## Next Steps

* [Running locally in Development](docs/development.md)
* [Deploying to Production](docs/production.md)

## Issues

If you run into any trouble, use the [SellRepo](https://github.com/excid3/sellrepo) issues and discussions for help.

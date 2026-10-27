# Personal Site

Personal blog, contact and portfolio site.

Built with [Bridgetown](https://www.bridgetownrb.com/). Requires Ruby (see
`.ruby-version`) and Node 22+ with yarn.

```bash
# Install dependencies
bundle install
yarn install

# Build the frontend assets (Tailwind CSS + JavaScript)
yarn build

# Build the site into output/
bundle exec bridgetown build

# Development server (frontend bundler + site watcher)
bundle exec bridgetown start
```

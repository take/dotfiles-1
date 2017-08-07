# My serverkit

A chain of configurations for my laptop.

## Usage

```sh
curl -LSfs https://raw.githubusercontent.com/take/my-serverkit/master/install.sh | bash
```

## Manual steps

- `git submodule init ; git submodule update` in dotfiles
- apply private serverkit
- load iTerm preferences from dotfiles/plist/
- install google japanese IME
- install app store apps
  - line
- login to each apps
- display sleep settings(might be automated via `pmset` and `defaults` command)

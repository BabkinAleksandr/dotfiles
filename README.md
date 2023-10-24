# Dotfiles

Use GNU `stow` to create config's symlinks.

1. Clone this repo to your home dir

2. Use GNU `stow` to create symlinks to to this repo.

Individual config:

```
stow nvim
```

Or all at once:

```
stow */
```

This will create corresponding symlinks in your `.config` directory:

```
HOME/
  .config/
    nvim
      ...
    alactirry
      ...
```

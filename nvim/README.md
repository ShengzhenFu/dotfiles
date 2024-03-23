# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.


## trash instead of direct remove in Neo-tree
There is a known issue that if you press d to remove file in Neo-tree, it will be immediately removed and can't be restored. To fix this issue i use trash to put the file to ~/.Trash

add below lines to init.lua

```lua
require("neo-tree").setup({
  filesystem = {
    commands = {
      -- Override delete to use trash instead of rm
      delete = function(state)
        local inputs = require("neo-tree.ui.inputs")
        local path = state.tree:get_node().path
        local msg = "Are you sure you want to trash " .. path
        inputs.confirm(msg, function(confirmed)
          if not confirmed then
            return
          end
          vim.fn.system({ "trash", vim.fn.fnameescape(path) })
          require("neo-tree.sources.manager").refresh(state.name)
        end)
      end,
    },
  },
})
```

Please also install trash on the MacOS
```bash
brew install trash
```

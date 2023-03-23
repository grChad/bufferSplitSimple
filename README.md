# ¿Que es bufferSplitSimple?

> Es un clone de [Idelosa/buffertag](https://github.com/ldelossa/buffertag), pero con pequeños cambios

<p align="center">
  <img src="https://github.com/GabrielRIP/my-assets/blob/main/plugs-lua/bufferSplitSimple/image-01.png" alt="imagen de 3 ventanas" />
</p>

<p align="center">
  <img src="https://github.com/GabrielRIP/my-assets/blob/main/plugs-lua/bufferSplitSimple/image-01.png" alt="imagen con NvimTree" />
</p>

- No tiene ninguna ruta anterior: Solo _FileName_ y _FileType_
- Se agrego **Iconos** con [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

## Requisitos:

Para usar de manera mas cómoda se recomienda tener activado `laststatus = 3`

```vim
  set laststatus=3          "Para Vim
```

```lua
  vim.opt.laststatus = 3    -- Para lua
```

## Pendiente:

- [ ] Agregar color a los iconos.

## uso:

Con [packer](https://github.com/wbthomason/packer.nvim):

```lua
  use {
      'GabrielRIP/bufferSplitSimple',
      config = function()
          require('buffer-split-simple').setup()
      end
  }
```

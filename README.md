<h1 align="center">¿Que es bufferSplitSimple?</h1>

> Es un clone de [Idelosa/buffertag](https://github.com/ldelossa/buffertag), pero con pequeños cambios

<p align="center">
  <img src="https://github.com/GabrielRIP/my-assets/blob/main/plugs-lua/bufferSplitSimple/image-01.png" alt="imagen de 3 ventanas" />
</p>

<p align="center">
  <img src="https://github.com/GabrielRIP/my-assets/blob/main/plugs-lua/bufferSplitSimple/image-01.png" alt="imagen con NvimTree" />
</p>

- No tiene ninguna ruta anterior: Solo _FileName_ y _FileType_
- Se agrego **Iconos** con [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

## uso:

Con [packer](https://github.com/wbthomason/packer.nvim):

```lua
use {
    'gr92/bufferSplitSimple',
    config = function()
        require('buffer-split-simple').setup()
    end
}
```

## Pendiente:

- [x] Agregar color a los iconos.
- [ ] Problemas de color en buffers al tener más de 3 abiertos.

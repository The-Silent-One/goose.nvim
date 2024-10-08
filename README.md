<a name="readme-top"></a>
# goose.nvim
a goose that rains terror on your vim IDE


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about">About</a>
    </li>
    <li>
        <a href="#installation">Installation</a>
    </li>
    <li>
        <a href="#to-do">To-do</a>
    </li>
    <li>
        <a href="#license">License</a>
    </li>
  </ol>
</details>

## About

https://github.com/user-attachments/assets/f5ace02a-278e-4b24-b08d-d7f7f94893d5

a neovim plugin that brings a goose that moves and honkes and keeps you entertained. This plugin was inspired by [duck.nvim](https://github.com/tamton-aquib/duck.nvim).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Installation

You need to install ffplay ([ffmpeg](https://www.ffmpeg.org)) first.

Add the plugin to your init.lua file like this:

```
{
    'The-Silent-One/goose.nvim',
    config = function()
      vim.keymap.set('n', '<leader>GG', function()
        require('goose').hatch()
      end, {})
      vim.keymap.set('n', '<leader>GK', function()
        require('goose').cook()
      end, {})
    end,
  },
```

You should configure the keymaps inside the config function

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## To-do

<ul>
    <li>
        Improve honk function
    </li>
    <li>
        Make goose able to interact with editor (steal a character?)
    </li>
    <li>
        Make goose stop and ponder
    </li>
    <li>
        Make goose interactable with cursor/mouse click
    </li>
    <li>
        Give goose the ability to fight back
    </li>
    <li>
        Improve cooking effects
    </li>
</ul>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

Distributed under the MIT license. See 'License.txt' for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

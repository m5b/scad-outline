# scad-outline.vim

A clean, minimal OpenSCAD outline sidebar for Vim.

`scad-outline.vim` adds a right-hand outline panel that lists all `module` and `function` definitions in your `.scad` files.  
It works without external plugins or tag generators and integrates naturally into your Vim workflow.

![screenshot](scad-outline.png)

---

## ✨ Features

- Displays all `module` and `function` names in a right-hand vertical sidebar
- Jump to any item by pressing `<Enter>`
- Toggle the sidebar with `<F6>`
- No dependencies, no tags, no ctags — just Vim

---

## 🔧 Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'm5b/scad-outline', { 'branch': 'main' }

